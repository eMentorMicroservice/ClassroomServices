class RoomsController < ApplicationController

  def create
    user = room_params[:user_id]
    teacher = room_params[:teacher_id]

    @room = Room.request(user, teacher)
    if @room 
      render json: {status: 200, room: @room.id}
    else
      render json: {status: 404}
    end
  end

  def test
    render json: {fuck: 'ok'}
  end

  def find
    user_id = params[:user_id]
    @room = Room.find_by_active_user(user_id)
    if @room
      render json: {status: 200, room_id: @room.id}
    else
      render json: {status: 404}
    end
  end

  def send_message
    @room = Room.find(params[:room_id])
    @message = @room.messages.build(user_id: params[:user_id], content: params[:message])
    if @message.save
      ClassroomChannel.broadcast_to(@room, type: 'MESSAGE', data: @message.to_json)
      render json: {status: 200, message_id: @message.id}
    else
      render json: {status: 404, error: @message.error}
    end
  end

  def get_info
    room = Room.find_by(id: params[:room_id])
    render :json => room, except: [:created_at, :updated_at], include: [{participants: {only: :user_id}}, {messages: {only: [:id, :user_id, :content]}}]
  end

  def send_info
    @room = Room.find(params[:room_id])
    info = params[:info]
    ClassroomChannel.broadcast_to(@room, type: 'INFO', data: info)
    render json: {status: 200}
  end

  def extend_class
    time_hours = params[:hours]
    room = Room.find_by(id: params[:room_id])
    if room
      if room.isActive?
        new_room = room.extend_class(time_hours.to_f)
        render json: {status: 200, room_id: new_room.id, end_at: new_room.end_at}
      else
        render json: {status: 404, error: 'ROOM IS ALREADY ENDED'}
      end
    else
      render json: {status: 404, error: 'CANNOT FIND ROOM'}
    end
  end

  private

  def room_params
    params.permit(:user_id, :teacher_id)
  end

end
