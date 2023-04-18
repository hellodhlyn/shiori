class AddProfilesToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :description, :string, null: true
    add_column :users, :website_url, :string, null: true
  end
end
