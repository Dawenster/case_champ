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

    # Remove leading &nbsp; spaces, if present
    @competition.category = @competition.category.gsub(/^\W{3}/,"")

    @competition.events.first.image_url = upload_image_to_cloudinary

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
    @events = Event.published
    if params[:search].present?
      set_search_filter
    else
      set_filters_and_sorts
    end
  end

  def show
    @competition = Competition.find(params[:id])
    @event = Event.find_by_id(params[:event_id]) || @competition.events.published.last || @competition.events.last
    redirect_to(:back || root_path, alert: "You are not an admin") and return if @event.unpublished? && !current_user.is_admin?

    begin
      @application_url = URI::HTTP.build(host: @event.application_url).to_s
    rescue
      @application_url = @event.application_url
    end
    flash.now[:notice] = "This competition is not published yet - only admins can see it for now" unless @event.published
  end

  def update
    @competition = Competition.find(params[:id])
    @event = Event.find(params[:event_id])

    # If admin linked the event to an existing competition
    if @competition.id != params[:competition][:id].to_i
      @event.competition_id = params[:competition][:id]
      @competition.destroy
    end

    @event.published = true
    if @event.save
      redirect_to competition_path(@event.competition, event_id: @event.id), notice: "Event successfully published"
    else
      redirect_to competition_path(@event.competition, event_id: @event.id), alert: @event.errors.full_messages.to_sentence
    end
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
    cloudinary_object = Cloudinary::Uploader.upload(raw_image)
    cloudinary_object['public_id']
  rescue => e
    Rollbar.error(e)
    Competition::DEFAULT_IMAGE
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

  def set_filters_and_sorts
    set_time_filter
    set_category_filter
    set_sort
  end

  def set_time_filter
    if params[:time].present?
      time_text = params[:time].gsub("-", " ").try(:humanize)
      @time_selected = Competition::TIMES.include?(time_text) ? time_text : Competition::DEFAULT_TIME
    else
      @time_selected = Competition::DEFAULT_TIME
    end

    case @time_selected
    when Competition::PAST
      @events = @events.past
    else
      @events = @events.upcoming
    end
  end

  def set_category_filter
    if params[:category].present?
      category_text = params[:category].gsub("-", " ").try(:humanize)
      @category_selected = Competition::CATEGORIES_WITH_ALL.include?(category_text) ? category_text : Competition::DEFAULT_CATEGORY
    else
      @category_selected = Competition::DEFAULT_CATEGORY
    end

    @events = @events.joins(:competition).where("competitions.category = ?", @category_selected) unless @category_selected == Competition::DEFAULT_CATEGORY
  end

  def set_sort
    if params[:sort].present?
      sort_text = params[:sort].gsub("-", " ").try(:humanize)
      @sort_selected = Competition::SORT_VALUES.include?(sort_text) ? sort_text : Competition::DEFAULT_SORT_VALUE
    else
      @sort_selected = Competition::DEFAULT_SORT_VALUE
    end

    case @sort_selected
    when Competition::PRIZE
      @events = @events.sort_by_prize
    when Competition::INTEREST
      @events = @events.sort_by_interest
    else
      @events = @events.sort_by_date
    end
  end

  def set_search_filter
    search_term = "%#{params[:search].strip.downcase}%"
    @events = @events.joins(:competition).where(
      "LOWER(competitions.name) like '#{search_term}' OR " \
      "LOWER(competitions.category) like '#{search_term}' OR " \
      "LOWER(events.name) like '#{search_term}' OR " \
      "LOWER(events.description) like '#{search_term}'"
    )
  end

end
