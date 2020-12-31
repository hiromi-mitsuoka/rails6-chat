class HomeController < ApplicationController
  # ユーザーがログイン済みの時はアクセス許可。未ログインの時はroot_pathにリダイレクト
  before_action :authenticate_user!, only: %i(index)
  
  def index
    # user_signed_in? : ログイン済みの時はtrue
    # current_user : ログイン済みの場合はログインユーザーを返す
    # ログイン済みの場合、crrent_userのidをログに書き込む
    if user_sign_in?
      loggeer.debug current_user.id
    end
  end
  
  
end
