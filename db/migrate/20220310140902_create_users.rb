class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :user_id, null: false
      t.string :display_name, null: false
      t.string :email, null: false
      t.string :profile_image_url
      t.timestamps

      t.index :user_id, unique: true
      t.index :display_name, unique: true
      t.index :email, unique: true
    end

    add_reference :posts, :author
  end
end
