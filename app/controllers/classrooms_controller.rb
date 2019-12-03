class ClassroomsController < ApplicationController

  def create
    
  end

  def send
    @room = session_params[:room_id]
    ActionCable.server.broadcast "classroom_channel_#{@room}", session_params
  end

  private
  
  def session_params
    params.permit(:type, :from, :to, :sdp, :candidate, :room_id, :message);
  end
end
