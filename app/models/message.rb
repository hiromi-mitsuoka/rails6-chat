class Message < ApplicationRecord
  validates :user_id, presence: true
  validates :content, presence: true
  
  # データ作成後にjob実行
  # after_create_commit { MessageBroadcastJob.perform_later self }
  
  belongs_to :user
  
  def template
    ApplicationController.renderer.render partial: "messages/message",
                                          locals: { message: self }
  end
end
