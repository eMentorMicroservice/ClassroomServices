class RoomsController < ApplicationController

  def create
    user = room_params[:user_id]
    teacher = room_params[:teacher_id]

    @room = Room.request(user, teacher)
    if @room 
      render json: {status: 'SUCCESS', room: @room.id}
    else
      render json: {status: 'FAILED'}
    end
  end

  def test
    render json: {fuck: 'ok'}
  end

  def find
    user_id = params[:user_id]
    @room = Room.find_by_active_user(user_id)
    if @room
      render json: {status: 'SUCCESS', room_id: @room.id}
    else
      render json: {status: 'FAILED'}
    end
  end

  def send_message
    @room = Room.find(params[:room_id])
    @message = @room.messages.build(user_id: params[:user_id], content: params[:message])
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

  def room_params
    params.permit(:user_id, :teacher_id)
  end

end
