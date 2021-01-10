class FavoritesController < ApplicationController
  def create
    @message = Message.find(params[:message_id])
    favorite = current_user.favorites.build(message_id: params[:message_id])
    favorite.save
    # redirect_to rooms_show_path
  end

  def destroy
    @message = Message.find(params[:message_id])
    favorite = Favorite.find_by(message_id: params[:message_id], user_id: current_user.id)
    favorite.destroy
    # redirect_to rooms_show_path
  end
end
