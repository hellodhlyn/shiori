class CreateReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :reactions do |t|
      t.references :user
      t.references :post
      t.string :content, null: false
      t.timestamps
    end
  end
end
