class UserMailer < ActionMailer::Base
  SKIP_INCOMPLETE_CHECK = ["how_did_you_learn_explanation"]

  default from: "scholarships@pflag.org"
  layout 'pflag_mailer'
  def incomplete_application_email(user)
    @user = user
    if @user.application.blank?
      puts "blank"
      return
    else
      @application = @user.application
    end
    @applications = @user.applications
    @id = @application.id
    @name = @user.name
    @email = @user.email
    @signed = @application.signature_stamp.present?
    @reference_name = @application.references.last.name unless @application.references.blank?
    if @application.references.present?
	    @references = @application.references.select{|s| s.completed.present? }.count 
  	else
		  @references = 0
	  end

    @transcript = @application.transcript.present?
    @essay = @application.essay.present?


    @blank_fields = @application.blank_fields
    @blank_fields_count = @application.blank_fields_count

    ##{root_url}
    @url  = "https://pflag-scholarship.herokuapp.com/applications/#{@id}/edit"
    mail(to: @email, subject: 'Your Application for the PFLAG National Scholarship')
  end
end
