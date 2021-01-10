module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # cookieの情報からcurrent_userを作成
    
    # identified_by :current_user

    # def connect
    #   self.current_user = find_verified_user
    # end

    # protected

    # def find_verified_user
    #   if verified_user = User.find_by(id: session['user_id'])
    #     verified_user
    #   else
    #     reject_unauthorized_connection
    #   end
    # end

    # def session
    #   cookies.encrypted[Rails.application.config.session_options[:key]]
    # end
    
    # identified_by :current_user

    # def connect
    #   reject_unauthorized_connection unless find_verified_user
    # end

    # private

    # def find_verified_user
    #   self.current_user = env['warden'].user
    # end
  end
end
