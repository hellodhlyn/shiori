class CreateSitesAndNamespaces < ActiveRecord::Migration[7.0]
  def change
    create_table :sites do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.timestamps

      t.index :slug, unique: true
    end

    create_table :namespaces do |t|
      t.references :site
      t.string :name, null: false
      t.string :slug, null: false
      t.timestamps

      t.index :slug, unique: true
    end

    create_table :posts do |t|
      t.references :namespace
      t.string :uuid, null: false
      t.string :title, null: false
      t.string :slug, null: false
      t.text :description
      t.string :thumbnail_url
      t.timestamps

      t.index :uuid, unique: true
    end
  end
end
