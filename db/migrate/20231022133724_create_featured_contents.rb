class CreateFeaturedContents < ActiveRecord::Migration[7.0]
  def change
    create_table :featured_contents do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.string :description
      t.timestamps
    end

    create_table :featured_content_posts do |t|
      t.references :featured_content
      t.references :post
      t.timestamps
    end
  end
end
