class ApplicationsController < ApplicationController
#require 'will_paginate/array'
  # GET /applications
  # GET /applications.json
  skip_authorization_check :only => [:new, :create]
  load_and_authorize_resource
  before_filter :filter_applications, :only => :index


  def index
    if (current_user.is? :admin and params.count == 2)
      params[:essay]='1'
      params[:reference]='1'
    end

    if (current_user.is? :reviewer and @applications.count == 0)
      flash[:alert] = "You have not yet been assigned applications to review. Please check back shortly"
    end

    filter_applications
    if request.format.to_sym == :html
      @applications = @applications.paginate(:page => params[:page], :per_page => (params[:per_page] || 15))
#      @applications = Application.search(params)
    end

    respond_to do |format|
      format.html #{ render action: "index", notice: @message}
      format.json { render json: @applications }
      format.csv { render csv: @applications }
    end
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
    @application = Application.find(params[:id])
    @reference = @application.references.completed.first
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @application }
    end
  end

  # GET /applications/new
  # GET /applications/new.json
  def new
    @application = Application.new({:applicant_user_id => current_user.id})
    
    current_user.applications.push @application

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @application }
    end
  end

  # GET /applications/1/edit
  def edit
    @application = Application.find(params[:id])
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = Application.new(params[:application])

    respond_to do |format|
      if @application.save
        format.html { redirect_to applications_path, notice: 'Application was successfully created.' }
        format.json { render json: @application, status: :created, location: @application }
      else
        format.html { render action: "new" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def sign
    @application = Application.find(params[:id])
    @application.signature_stamp = DateTime.now
    @application.signature_ip = request.remote_ip

    respond_to do |format|
      if @application.save
        flash[:notice] = t("application.message.sign_success")
        format.js
      else
        flash[:danger] = t("application.message.sign_failed")
        format.js
      end
    end
  end

  def unsign
    @application = Application.find(params[:id])
    @application.signature_stamp = nil
    @application.signature_ip = nil
    respond_to do |format|
      if @application.save
        flash[:notice] = t("application.message.unsign_success")
        format.js 
      else
        flash[:danger] = t("application.message.unsign_failed")
        format.js
      end
    end
  end

  # PUT /applications/1
  # PUT /applications/1.json
  def update
    @application = Application.find(params[:id])
    notice = nil
    if (params[:delete_transcript] == "1")
      @application.transcript.destroy
      @application.transcript.clear
      notice = "Transcript deleted."
      @application.save
    end

      
    if (params[:delete_photo] == "1")
      @application.photo.destroy
      @application.photo.clear
      notice = "Photo deleted."
      @application.save
    end
    respond_to do |format|
      if @application.update_attributes(params[:application])
        format.html { redirect_to edit_application_path, notice: (notice || t("application.message.save_success")) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_multiple
    @applications = Application.find_all_by_id(params[:application_ids])
    errors = Array.new
    reviewer = nil
    if params[:reviewer].blank? && params[:replace_reviewers] == '1'
      errors.push "Reviewers removed."
    else
      reviewer = User.find(params[:reviewer])
    end
    replace = params[:replace_reviewers] == '1'
    @applications.each do |a| 
      params[:reviewers]
      if replace
        a.replace_reviewers reviewer
      else
        if params[:reviewer].blank? 
           errors.push "No reviewer selected. Check replace if you meant to remove all reviewers assigned."
        else
          a.add_reviewer reviewer
        end
      end
      a.save!
    end
    message =  (errors.length > 0) ? errors.join(", ") : "Applications successfully updated."
    redirect_to applications_path({essay: '1', reference: '1', page: params[:page]}), notice: message

  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application = Application.find(params[:id])
    @application.destroy

    respond_to do |format|
      format.html { redirect_to applications_url }
      format.json { head :no_content }
    end
  end

  private
  def filter_applications
    sort = params[:sort]
    @review = params[:sort].in? ['score','stem','first_generation']

    case sort
    when 'score'
      @applications = @applications.with_score
    when 'first_generation'
      @applications = @applications.with_score_by_first_generation
    when 'stem'    
      @applications = @applications.with_score_by_stem
    else
      @applications = @applications.includes(:users).where("users.id = applications.applicant_user_id").order("LOWER(users.name)")
      @applications = @applications.where("users.name ILIKE ?","%#{params[:name]}%")if params[:name].present?
      @applications = User.find(params[:user_id]).applications if params[:user_id].present?
      @applications = @applications.has_transcript if params[:transcript] == '1'
      @applications = @applications.is_signed if params[:signed] == '1'
      @applications = @applications.has_essay if params[:essay] == '1'
      @applications = @applications.has_reference if params[:reference] == '1'
      @applications = @applications.select{|d| d.blank_fields_count == 0} if params[:completed] == '1'
    end
  end

end
