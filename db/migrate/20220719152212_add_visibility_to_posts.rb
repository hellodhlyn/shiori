class AddVisibilityToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :visibility, :string, null: false, default: "private"
    change_column_default :posts, :visibility, ""
  end
end
