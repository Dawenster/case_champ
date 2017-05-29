class EventFilesController < ApplicationController

  before_action :redirect_to_login, unless: :user_logged_in?

  def create
    redirect_to :back, alert: "Please select a file first" and return if params[:event_file]["public_id"].blank?

    event_file = EventFile.new(event_file_params)
    cloudinary_object = cloudinary_upload

    if cloudinary_object[:error]
      redirect_to :back, alert: cloudinary_object[:message]
    else
      event_file.user              = current_user
      event_file.original_filename = cloudinary_object["original_filename"]
      event_file.public_id         = cloudinary_object["public_id"]
      event_file.resource_type     = cloudinary_object["resource_type"]
      event_file.secure_url        = cloudinary_object["secure_url"]


      if event_file.save
        redirect_to :back, notice: "#{event_file.original_filename} successfully uploaded"
      else
        redirect_to :back, alert: event_file.errors.full_messages.to_sentence
      end
    end
  end

  def destroy
    event_file = EventFile.find(params[:id])
    if event_file.destroy
      redirect_to :back, notice: "File successfully deleted"
    else
      redirect_to :back, alert: event_file.errors.full_messages.to_sentence
    end
  end

  private

  def event_file_params
    params.require(:event_file).permit(
      :id,
      :event_id
    )
  end

  def cloudinary_upload
    raw_file = params[:event_file]["public_id"]
    Cloudinary::Uploader.upload(raw_file, resource_type: :auto)
  rescue => e
    Rollbar.error(e)
    { message: e.message, error: true}
  end

end
