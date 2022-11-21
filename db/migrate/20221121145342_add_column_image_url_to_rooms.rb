class AddColumnImageUrlToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :image_url, :string
  end
end
