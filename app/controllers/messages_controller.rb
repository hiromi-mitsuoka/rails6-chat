class MessagesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @message = current_user.messages.create!(message_params)
    # 投稿されたメッセージを全員に配信
    # template : message.rbに記述
    ActionCable.server.broadcast "room_channel", message: @message.template
  end
  
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to rooms_show_path
  end
  
  private
  
    def message_params
      params.require(:message).permit(:content, { images: [] })
    end
end
