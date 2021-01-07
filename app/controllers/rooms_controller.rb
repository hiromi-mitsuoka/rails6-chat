class RoomsController < ApplicationController
  
  # deviseのログイン確認
  before_action :authenticate_user!
  
  def show
    # includes : モデルの情報取得時の性能低下を防ぐために、関連付けられているモデルをあらかじめ取得
    # 最初の50件のみ取得
    @messages = Message.includes(:user).order(:id).last(50)
    # message投稿時に利用
    @message = current_user.messages.build
    
    @messenger = current_user
  end
  
  def show_additionally
    # 追加の50件を取得
    last_id = params[:oldest_message_id].to_i - 1
    @messages = Message.includes(:user).order(:id).where(id: 1..last_id).last(50)
  end
  
end
