class ApplicationsController < ApplicationController
  # GET /applications
  # GET /applications.json
  skip_authorization_check :only => [:new, :create]
  load_and_authorize_resource

  def index
    @applications = Application.accessible_by(current_ability)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @applications }
    end
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
    @application = Application.find(params[:id])

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
    authorize! :manage, @application
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
    authorize! :manage, @application
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

    respond_to do |format|
      if @application.update_attributes(params[:application])
        format.html { redirect_to @application, notice: 'Application was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
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
end
