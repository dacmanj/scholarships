class ReferenceMailer < ActionMailer::Base
  default from: "scholarships@pflag.org"
  layout 'reference_mailer'
  def send_reference_request_email(reference)
    @reference = reference
    @user = @reference.user
    @url  = "#{root_url}references/token/#{reference.token}"
    mail(to: @reference.email, subject: 'Reference Request: PFLAG National Scholarship')
  end

  def send_reference_request_confirmation_email(reference)
  	@reference = reference
    @user = @reference.user
    @url  = "#{root_url}references/token/#{reference.token}"
    mail(to: @reference.user.email, subject: 'PFLAG National Scholarship Reference Request Sent')
  end

  def reference_confirmation_email(reference)
    @reference = reference
	email_with_name = "#{@reference.name} <#{@reference.email}>"
	student_email_with_name = "#{@reference.user.name} <#{@reference.user.email}>"
    mail(to: email_with_name, cc: student_email_with_name, subject: 'Reference Confirmation: PFLAG National Scholarship')
  end
end
