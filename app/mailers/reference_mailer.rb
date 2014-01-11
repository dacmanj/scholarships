class ReferenceMailer < ActionMailer::Base
  default from: "scholarships@pflag.org"
  def send_reference_request_email(reference)
    @reference = reference
    @user = @reference.user
    @url  = 'http://example.com/login'
    mail(to: @reference.email, subject: 'Reference Request: PFLAG National Scholarship')
  end
end
