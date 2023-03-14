class DropPostBlobs < ActiveRecord::Migration[7.0]
  def change
    drop_table :post_blobs

    add_column :blobs, :content_tmp, :jsonb, default: {}

    Blob.all.each { |blob| blob.update!(content_tmp: { "text" => blob.content }) }

    remove_column :blobs, :content
    rename_column :blobs, :content_tmp, :content
  end
end
