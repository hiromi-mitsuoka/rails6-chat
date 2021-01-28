class AddImagesToDmMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :dm_messages, :images, :json
  end
end
