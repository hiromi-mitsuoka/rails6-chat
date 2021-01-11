class DmMessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  
  def create
    if DmEntry.where(user_id: current_user.id, dm_room_id: params[:dm_message][:dm_room_id]).present?
      @dm_message = DmMessage.create!(dm_message_params)
      @dm_message_user = current_user
      
      @dm_room_id = @dm_message.dm_room_id
      
      5.times { puts "#{@dm_room_id}" }
      # templateはdm_messsage.rbで定義
      redirect_to "/dm_rooms/#{ @dm_message.dm_room_id }"
      ActionCable.server.broadcast "dm_room_channel_#{@dm_room_id}", dm_message: @dm_message.template
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    @dm_message_user = current_user
    @dm_message = DmMessage.find(params[:id])
    @dm_message.destroy
    redirect_to "/dm_rooms/#{ @dm_message.dm_room_id }"
  end
  
  private
  
    def dm_message_params
      params.require(:dm_message).permit(:user_id, :content, :dm_room_id, { images: [] })
                                  .merge(user_id: current_user.id)
    end
  
end
