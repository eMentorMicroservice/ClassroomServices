class NotifyChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_notify_#{params[:user_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
