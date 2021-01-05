class Message < ApplicationRecord
  validates :user_id, presence: true
  
  # imageのみ投稿も行いため一旦削除
  # validates :content, presence: true
  
  # imagesカラムとImageUploaderクラスを紐付け
  mount_uploaders :images, ImageUploader
  # SQLiteを使用している場合の追記
  # serialize :images, JSON
  
  # データ作成後にjob実行
  # after_create_commit { MessageBroadcastJob.perform_later self }
  
  belongs_to :user
  
  def template
    ApplicationController.renderer.render partial: "messages/message",
                                          locals: { message: self }
  end
end
