class ApplicationController < ActionController::Base
  
  # devise_controller? : deviseコントローラーの時だけtrue
  before_action :configure_permitted_parameters, if: :devise_controller?
  # 全ページログイン必須
  before_action :authenticate_user!
  
  
  private
  
    # ログアウト後のリダイレクト先変更
    # def after_sign_out_path_for
      # root_pathからsign_inに変更
      # new_user_session_path
    # end
    
    # サインアップ時のリダイレクト先
    # def after_sign_up_path_for
    # end
    
    # サインイン時のリダイレクト先変更
    # def after_sign_in_path_for
    # end
  
  
  protected
  
    def configure_permitted_parameters
      # Strong Parameterにnameも追加
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    end
end
