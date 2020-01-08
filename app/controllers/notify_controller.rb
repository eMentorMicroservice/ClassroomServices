class NotifyController < ApplicationController
  def send_message
    @from = params[:from]
    @to = params[:to]
    @message = params[:message]
    NotifyChannel.broadcast_to(@to, {message: @message})
  end

  def send_offer
    @from = params[:from]
    @to = params[:to]
    ActionCable.server.broadcast("user_notify_#{@to}", {
      type: 'OFFER',
      from: @from,
    })
  end

  def accept_offer
    @from = params[:from]
    @to = params[:to]
    ActionCable.server.broadcast("user_notify_#{@to}", {
      type: 'ANSWER',
      message: 'ACCEPTED',
    })
    render json: {status: 200}
  end

  def decline_offer
    @from = params[:from]
    @to = params[:to]
    ActionCable.server.broadcast("user_notify_#{@to}", {
      type: 'ANSWER',
      message: 'DECLINED',
    })
  end
end
