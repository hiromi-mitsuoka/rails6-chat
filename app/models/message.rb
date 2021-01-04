class Message < ApplicationRecord
  validates :user_id, presence: true
  
  # imageのみ投稿も行いため一旦削除
  # validates :content, presence: true
  
  # imageカラムとImageUploaderクラスを紐付け
  mount_uploader :image, ImageUploader
  
  # データ作成後にjob実行
  # after_create_commit { MessageBroadcastJob.perform_later self }
  
  belongs_to :user
  
  def template
    ApplicationController.renderer.render partial: "messages/message",
                                          locals: { message: self }
  end
end
