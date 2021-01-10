class DmMessage < ApplicationRecord
  belongs_to :user
  belongs_to :dm_room
  
  mount_uploaders :images, ImageUploader
  
  def template
    ApplicationController.renderer.render partial: "dm_messages/dm_message", locals: { dm_message: self }
  end
end
