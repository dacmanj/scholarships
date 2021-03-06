class ReferencesController < ApplicationController
  # GET /references
  # GET /references.json
  load_and_authorize_resource
  skip_authorize_resource :only => [:edit, :update]
  skip_authorization_check :only => [:edit, :update]
  before_filter :filter_references, :only => :index

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @references }
    end
  end

  # GET /references/1
  # GET /references/1.json
  def show
    @reference = Reference.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reference }
    end
  end

  # GET /references/new
  # GET /references/new.json
  def new
    @reference = Reference.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reference }
    end
  end

  # GET /references/1/edit
  def edit
    @reference = Reference.find_by_token(params[:token])
    if @reference.nil? and !current_user.is? :admin
      redirect_to root_url, error: "Invalid Reference"
    elsif current_user.present? and current_user.is? :admin
      @reference = (Reference.find(params[:id]) unless(params[:id].blank?)) || Reference.find_by_token(params[:token])
    end
  end

  # POST /references
  # POST /references.json
  def create
    @reference = Reference.new(params[:reference])

    respond_to do |format|
      if @reference.save
        format.html { redirect_to @reference, notice: 'Reference was successfully created.' }
        format.json { render json: @reference, status: :created, location: @reference }
      else
        format.html { render action: "new" }
        format.json { render json: @reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /references/1
  # PUT /references/1.json
  def update
    @reference = Reference.find(params[:id])
    @reference.completed = Time.new

    respond_to do |format|
      if @reference.update_attributes(params[:reference])
        ReferenceMailer.reference_confirmation_email(@reference).deliver
        format.html { redirect_to root_url, notice: 'Thank you for submitting your reference.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reference.errors, status: :unprocessable_entity }
      end
    end
  end

  def resend
    @reference = Reference.find(params[:id])

    respond_to do |format|

      if !@reference.nil?
        ReferenceMailer.send_reference_request_email(@reference).deliver
        format.html { redirect_to references_url, notice: 'Reference request was successfully resent.'  }

      else
        format.html { redirect_to references_url, notice: 'Reference request failed.'  }
        format.json { render json: @reference.errors, status: :unprocessable_entity }
      end
    end

  end

  def send_reference_request
    @reference = Reference.find_by_user_id_and_email(params[:reference][:user_id] || current_user.id,params[:reference][:email]) || Reference.new

    if @reference.token.blank?
      @reference.token = Array.new(32){[*'0'..'9', *'a'..'z', *'A'..'Z'].sample}.join
      @reference.user = (User.find(params[:reference][:user_id]) unless params[:reference][:user_id].blank?) || current_user
      @reference.email = params[:reference][:email]
      @reference.application = Application.find_by_applicant_user_id(params[:reference][:user_id] || current_user)
    end

    respond_to do |format|
      if @reference.save
          ReferenceMailer.send_reference_request_confirmation_email(@reference).deliver
          ReferenceMailer.send_reference_request_email(@reference).deliver
          format.html { redirect_to references_url, notice: 'Reference request was successfully sent.'  }
      else
          format.html { redirect_to references_url, notice: 'Reference request failed.'  }
          format.json { render json: @reference.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /references/1
  # DELETE /references/1.json
  def destroy
    @reference = Reference.find(params[:id])
    @reference.destroy

    respond_to do |format|
      format.html { redirect_to references_url }
      format.json { head :no_content }
    end
  end
  private
  def filter_references
    @references = @references.accessible_by(current_ability)
    @references = @references.where(application_id: params[:application_id]) if params[:application_id].present?
    @references = @references.where(user_id: params[:user_id]) if params[:user_id].present?
    @references = @references.where("email ILIKE ?","%#{params[:email]}%")if params[:email].present?

  end

end
