class MessagesController < ApplicationController
  def create
    @message = current_user.messages.create!(message_params)
    # 投稿されたメッセージを全員に配信
    # template : message.rbに記述
    ActionCable.server.broadcast "room_channel", message: @message.template
  end
  
  private
  
    def message_params
      params.require(:message).permit(:content)
    end
end
