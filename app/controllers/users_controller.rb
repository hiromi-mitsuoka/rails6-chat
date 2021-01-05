class UsersController < ApplicationController
  # deviseのcontollerではなく、ログイン後のdm用
  
  before_action :authenticate_user!, only: :show
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @currentUserDmEntry = DmEntry.where(user_id: current_user.id)
    @userDmEntry = DmEntry.where(user_id: @user.id)
    
    unless @user.id == current_user.id
      @currentUserDmEntry.each do |cu|
        @userDmEntry.each do |u|
          if cu.dm_room_id == u.dm_room_id then
            @isDmRoom = true
            @dmRoomId = cu.dm_room_id
          end
        end
      end
      
      unless @isDmRoom
        @dmRoom = DmRoom.new
        @dmEntry = DmEntry.new
      end
      
    end
  end
  
end
