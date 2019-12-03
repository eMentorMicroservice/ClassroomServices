class ClassroomChannel < ApplicationCable::Channel
  def subscribed
    @room_id = params[:room_id]
    
    stream_from "classroom_channel_#{@room_id}"
  end

  def send
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
