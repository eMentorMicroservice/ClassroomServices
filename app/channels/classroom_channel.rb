class ClassroomChannel < ApplicationCable::Channel
  def subscribed
    @teacher_id = params[:teacher_id]
    
    stream_from "classroom_channel_#{@user}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
