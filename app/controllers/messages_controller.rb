class MessagesController < ApplicationController
  before_action :authenticate_user!
  after_action :bloadcast, only: :create
  
  def create
    @message = current_user.messages.create!(message_params)
    @message_user = current_user

    # current_userを適応させるため
    redirect_to rooms_show_path
    # template : message.rbに記述
    # ActionCable.server.broadcast "room_channel",
    #       message: @message.template, user: current_user
  end
  
  def destroy
    @message_user = current_user
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to rooms_show_path
  end
  
  private
  
    def message_params
      params.require(:message).permit(:content, { images: [] })
    end
    
    def bloadcast
      ActionCable.server.broadcast "room_channel",
          message: @message.template, user: current_user
    end
    
    
end
