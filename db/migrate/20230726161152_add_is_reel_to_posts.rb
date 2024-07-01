class AddIsReelToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :is_reel, :boolean, default: false
  end
end
