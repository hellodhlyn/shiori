class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.references :namespace
      t.string :name, null: false
      t.string :slug, null: false
      t.timestamps
    end

    create_table :post_tags do |t|
      t.references :post
      t.references :tag
    end
  end
end
