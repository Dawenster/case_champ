class CompetitionsController < ApplicationController

  before_action :redirect_to_login, except: [:new, :create, :confirmation], unless: :user_logged_in?

  def new
    @competition = Competition.new
    @events = @competition.events.build
    3.times do
      @events.prizes.build
    end
    3.times do
      @events.milestones.build
    end
  end

  def create
    @competition = Competition.new(competition_params)

    @competition.category = @competition.category[3..-1]

    cloudinary_result = upload_image_to_cloudinary
    @competition.events.first.image_url = cloudinary_result["secure_url"]

    if @competition.save
      send_alerts_to_all_admins
      redirect_to confirmation_competitions_path, notice: "Competition created successfully"
    else
      @competition.category = add_leading_spaces(@competition.category)
      alert_message = "Sorry! Unable to submit: #{clean_up_competition_error_messages(@competition.errors)}"
      flash.now["alert"] = alert_message
      render "new"
    end
  end

  def confirmation
  end

  def index
    @competitions = Competition.all
  end

  private

  def competition_params
    params.require(:competition).permit(
      :id,
      :name,
      :category,
      events_attributes: [
        :id,
        :name,
        :sponsor,
        :description,
        :city,
        :state_and_country,
        :min_team_size,
        :max_team_size,
        :num_kellogg_teams_allowed,
        :logistics,
        :application,
        :application_url,
        :contact_name,
        :position_and_organization,
        :contact_email,
        :contact_phone,
        :competition_id,
        :image_url,
        :_destroy,
        prizes_attributes: [
          :id,
          :rank,
          :amount_in_dollars,
          :description,
          :event_id,
          :_destroy
        ],
        milestones_attributes: [
          :id,
          :deadline_at,
          :description,
          :event_id,
          :_destroy
        ]
      ]
    )
  end

  def upload_image_to_cloudinary
    raw_image = params[:competition]["events_attributes"]["0"]["image_url"]
    Cloudinary::Uploader.upload(raw_image)
  rescue => e
    Rollbar.error(e)
    {secure_url: nil}
  end

  def send_alerts_to_all_admins
    admins = User.admin
    admins.each do |admin|
      begin
        CompetitionMailer.submission_notification_to_admin(@competition, admin).deliver_now
      rescue => e
        Rollbar.error(e, competition_id: @competition.try(:id), admin_id: admin.try(:id))
      end
    end
  end

end
