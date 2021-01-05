class DmEntry < ApplicationRecord
  belongs_to :user
  belongs_to :dm_room
  
  validates :dm_room_id, uniqueness: { scope: :user_id }
end
