class AddBlurhashOnPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :thumbnail_blurhash, :string
  end
end
