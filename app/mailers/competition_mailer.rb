class CompetitionMailer < ApplicationMailer

  def submission_notification_to_admin(competition, admin)
    event = competition.events.last
    @first_name = admin.first_name
    @name = competition.name
    @organizer_name = event.contact_name
    @organizer_email = event.contact_email
    # TODO: Change to actual admin competition view page
    @url = Rails.application.routes.url_helpers.root_url(host: ENV["HOST"])
    mail(to: email_to_use(admin), subject: 'A competition has been submitted')
  end
  
end