class CreateAuthentications < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :uuid, :string
    rename_column :users, :user_id, :name
    change_column :users, :email, :string, null: true

    create_table :authentications do |t|
      t.references :user, null: false
      t.string :type, null: false
      t.string :identifier, null: false
      t.timestamps
    end
  end
end
