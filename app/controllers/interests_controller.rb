class InterestsController < ApplicationController

  before_action :redirect_to_login, unless: :user_logged_in?

  def create
    interest = Interest.new(interest_params)
    interest.user = current_user
    redirect_link = competition_path(interest.try(:event).try(:competition), tab: Competition::TAB_PARTICIPANTS, event_id: interest.event.try(:id))

    if interest.save
      redirect_to redirect_link, notice: "You just marked your interest for this competition"
    else
      redirect_to redirect_link, alert: interest.errors.full_messages.to_sentence
    end
  end

  def destroy
    interest = Interest.find(params[:id])
    redirect_link = competition_path(interest.try(:event).try(:competition), tab: Competition::TAB_PARTICIPANTS, event_id: interest.event.try(:id))

    if interest.destroy
      redirect_to redirect_link, notice: "You are no longer interested in this competition"
    else
      redirect_to redirect_link, alert: interest.errors.full_messages.to_sentence
    end
  end

  private

  def interest_params
    params.require(:interest).permit(
      :id,
      :event_id
    )
  end

end
