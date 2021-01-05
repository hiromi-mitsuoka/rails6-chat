class DmRoom < ApplicationRecord
  has_many :dm_entries, dependent: :destroy
  has_many :dm_messages, dependent: :destroy
  has_many :users, through: :dm_entries
end
