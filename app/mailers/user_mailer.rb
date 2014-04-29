class UserMailer < ActionMailer::Base
  default from: "scholarships@pflag.org"
  layout 'pflag_mailer'
  def incomplete_application_email(user)
    @user = user
    @application = @user.application
    @applications = @user.applications
    @id = @application.id
    @name = @user.name
    @email = @user.email
    @signed = @application.signature_stamp.present?
    if @application.references.present?
	    @references = @application.references.select{|s| s.completed.present? }.count 
	else
		@references = 0
	end

    @transcript = @application.transcript.present?
    @essay = @application.essay.present?
    @blank_fields = @application.attributes.select { |k,v| v.blank? }.keys
    @blank_fields_count = @application.attributes.select { |k,v| v.blank? }.count

    ##{root_url}
    @url  = "https://pflag-scholarship.herokuapp.com/applications/#{@id}"
    mail(to: "dmanuel@pflag.org", subject: 'Your Application for the PFLAG National Scholarship is not yet complete.')
  end
end
