class CreatePostDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :blobs do |t|
      t.string :uuid, null: false
      t.string :type
      t.text :content
      t.timestamps

      t.index :uuid, unique: true
    end

    create_table :post_blobs do |t|
      t.references :post, null: false
      t.references :blob, null: false
      t.bigint :index
    end
  end
end
