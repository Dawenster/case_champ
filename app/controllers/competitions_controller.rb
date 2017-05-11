class CompetitionsController < ApplicationController

  def new
    @competition = Competition.new
    @events = @competition.events.build
    3.times do
      @events.prizes.build
    end
  end

  private

  def competition_params
    params.require(:competition).permit(
      :id,
      :name,
      :category,

      event_attributes: [
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
        :_destroy,

        prize_attributes: [
          :id,
          :rank,
          :amount_in_dollars,
          :description,
          :event_id,
          :_destroy
        ],

        milestone_attributes: [
          :id,
          :deadline_at,
          :description,
          :event_id,
          :_destroy
        ]
      ]
    )
  end

end
