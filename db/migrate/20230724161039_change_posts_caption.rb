class ChangePostsCaption < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :caption, :text 
  end
end
