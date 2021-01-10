class DmMessagesController < ApplicationController
  before_action :authenticate_user!, only: :create
  
  def create
    if DmEntry.where(user_id: current_user.id, dm_room_id: params[:dm_message][:dm_room_id]).present?
      @dm_message = DmMessage.create!(dm_message_params)
      # templateはdm_messsage.rbで定義
      ActionCable.server.broadcast 'dm_room_channel_#{dm_message.dm_room_id}', dm_message: @dm_message.template
      redirect_to "/dm_rooms/#{ @dm_message.dm_room_id }"
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  
    def dm_message_params
      params.require(:dm_message).permit(:user_id, :content, :dm_room_id, { images: [] }).merge(user_id: current_user.id)
    end
  
end
