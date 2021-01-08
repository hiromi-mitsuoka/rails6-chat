class ApplicationController < ActionController::Base
  
  # devise_controller? : deviseコントローラーの時だけtrue
  before_action :configure_permitted_parameters, if: :devise_controller?
  # 全ページログイン必須
  before_action :authenticate_user!
  
  
  private
  
    # ログアウト後のリダイレクト先変更
    def after_sign_out_path_for(user)
      # root_pathからsign_inに変更
      new_user_session_path
    end
    
    # サインアップ時のリダイレクト先
    def after_sign_up_path_for(user)
      root_path
    end
    
    # サインイン時のリダイレクト先変更
    def after_sign_in_path_for(user)
      root_path
    end
  
  
  protected
  
    def configure_permitted_parameters
      
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
      
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
    end
    
    def self.render_with_signed_in_user(user, *args)
       ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
       proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap{|i| i.set_user(user, scope: :user) }
       renderer = self.renderer.new('warden' => proxy)
       renderer.render(*args)
     end
end
