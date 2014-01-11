class ReferencesController < ApplicationController
  # GET /references
  # GET /references.json
  load_and_authorize_resource
  def index
    @references = Reference.all
    @applications = Application.accessible_by(current_ability)

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
    @reference = Reference.find(params[:id])
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

    respond_to do |format|
      if @reference.update_attributes(params[:reference])
        format.html { redirect_to @reference, notice: 'Reference was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reference.errors, status: :unprocessable_entity }
      end
    end
  end

  def send_reference_request
    @reference = Reference.new
    @reference.token = Array.new(32){[*'0'..'9', *'a'..'z', *'A'..'Z'].sample}.join
    @reference.user = current_user
    @reference.email = params[:reference]["email"]
    @reference.application = current_user.application
    

    respond_to do |format|
      if @reference.save
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
end
