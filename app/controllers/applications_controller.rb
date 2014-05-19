class ApplicationsController < ApplicationController
require 'will_paginate/array'
  # GET /applications
  # GET /applications.json
  skip_authorization_check :only => [:new, :create]
  load_and_authorize_resource
  before_filter :filter_applications, :only => :index


  def index
    if request.format.to_sym == :html
      if (params.length == 2)
        params[:reference] = '1'
        params[:essay] = '1'
      end

      @applications = @applications.paginate(:page => params[:page]) 
    end

    respond_to do |format|
      format.html
      format.json { render json: @applications }
      format.csv { render csv: @applications }
    end
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
    @application = Application.find(params[:id])
    @reference = @application.references.first
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @application }
    end
  end

  # GET /applications/new
  # GET /applications/new.json
  def new
    @application = Application.new
    @application.user = current_user

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
      @application.transcript = nil
      notice = "Transcript deleted."
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
    redirect_to applications_path({essay: '1', reference: '1'}), notice: message

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
    @applications = Application.includes(:users).order("users.name")
    @applications = @applications.where("users.name ILIKE ?","%#{params[:name]}%").order("users.name") if params[:name].present?
    @applications = @applications.has_transcript if params[:transcript] == '1'
    @applications = @applications.is_signed if params[:signed] == '1'
    @applications = @applications.has_essay if params[:essay] == '1'
    @applications = @applications.has_reference if params[:reference] == '1'
    @applications = @applications.select{|d| d.blank_fields_count == 0} if params[:completed] == '1'
  end

end
