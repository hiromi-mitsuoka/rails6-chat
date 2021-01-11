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
  has_many :favorites
  
  def template
    # ApplicationController.renderer.render partial: "messages/message",
    #                                       locals: { message: self }
                                          
    # 変更前
    # ApplicationController.renderer.render('messages/message', locals: { post: @post })
    # 変更後
    # ApplicationController.render_with_signed_in_user(user, 'posts/post', locals: { post: @post })
    ApplicationController.render_with_signed_in_user(@message_user, partial: "messages/message",
                                          locals: { message: self })
  end
  
  # いいねしてるかどうかのメソッド
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  # 本人かどうか
  def current_user?(current_user)
    user_id == current_user.id
  end
end
