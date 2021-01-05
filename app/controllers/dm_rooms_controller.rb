class DmRoomsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @dm_room = DmRoom.create
    @entry1 = DmEntry.create(dm_room_id: @dm_room.id, user_id: current_user.id)
    @entry2 = DmEntry.create(params.require(:dm_entry)
                                  .permit(:user_id, :dm_room_id)
                                  .merge(dm_room_id: @dm_room.id))
    # redirect_to "/dm_rooms/#{@dm_room.id}"
    redirect_back dm_room_path(@dm_room_id)
  end
  
  def show
    @dm_room = DmRoom.find(params[:id])
    if DmEntry.where(user_id: current_user.id, dm_room_id: @dm_room.id).present?
      @dm_messages = @dm_room.dm_messages
      @dm_message = DmMessage.new
      @dm_entries = @dm_room.dm_entries
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
end
