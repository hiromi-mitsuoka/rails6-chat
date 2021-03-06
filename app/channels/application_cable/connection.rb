module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # cookieの情報からcurrent_userを作成
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected
    def find_verified_user
      verified_user = User.find_by(id: env['warden'].user.id)
      return reject_unauthorized_connection unless verified_user
      verified_user
    end
  end
end
