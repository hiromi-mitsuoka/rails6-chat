class DmMessage < ApplicationRecord
  belongs_to :user
  belongs_to :dm_room
  
  def template
    ApplicationController.renderer.render partial: "dm_messages/dm_message", locals: { dm_message: self }
  end
end
