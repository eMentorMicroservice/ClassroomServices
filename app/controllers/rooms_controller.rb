class RoomsController < ApplicationController
  def find_room
    user_id = params[:user_id]
    @room = Room.find_by_active_user(user_id)
    if @room
      render json: {status: 'SUCCESS', room: @room.id}
    else
      render json: {status: 'FAILED'}
    end
  end

  def send_message
    @room = Room.find(params[:room_id])
    @message = @room.messages.build(user_id: params[:user_id])
    if @message.save
      ClassroomChannel.broadcast_to(@room, type: 'MESSAGE', data: @message)
      render json: {success: true}
    else
      render json: {status: 'FAILED', errors: @message.errors}
    end
  end

  def send_info
    @room = Room.find(params[:room_id])
    info = params[:info]
    ClassroomChannel.broadcast_to(@room, type: 'INFO', data: info)
    render json: {success: true}
  end

  private

end
