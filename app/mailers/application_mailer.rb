class ApplicationMailer < ActionMailer::Base
  
  default from: '"Kellogg Competitions" <competitions@kellogg.northwestern.edu>'

  def email_to_use(user)
    if ENV["CASE_CHAMP_ENVIRONMENT"] == "production"
      user.email
    elsif test_email.present?
      test_email
    else
      test_sendgrid_email
    end
  end

  def test_email
    ENV["TEST_EMAIL"]
  end

  def test_sendgrid_email
    "test@sink.sendgrid.net"
  end

end