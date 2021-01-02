class RoomsController < ApplicationController
  
  # deviseのログイン確認
  before_action :authenticate_user!
  
  def show
    # includes : モデルの情報取得時の性能低下を防ぐために、関連付けられているモデルをあらかじめ取得
    @messages = Message.includes(:user).order(:id)
    # message投稿時に利用
    @message = current_user.messages.build
  end
  
end
