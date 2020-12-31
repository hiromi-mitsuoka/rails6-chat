class ApplicationController < ActionController::Base
  
  # devise_controller? : deviseコントローラーの時だけtrue
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  
  protected
  
    def configure_permitted_parameters
      # Strong Parameterにnameも追加
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
