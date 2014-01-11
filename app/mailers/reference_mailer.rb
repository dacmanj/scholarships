class ReferenceMailer < ActionMailer::Base
  default from: "scholarships@pflag.org"
  def send_reference_request_email(reference)
    @reference = reference
    @user = @reference.user
    @url  = "#{root_url}references/token/#{reference.token}"
    mail(to: @reference.email, subject: 'Reference Request: PFLAG National Scholarship')
  end
end
