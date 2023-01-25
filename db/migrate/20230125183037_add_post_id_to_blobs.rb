class AddPostIdToBlobs < ActiveRecord::Migration[7.0]
  def change
    add_reference :blobs, :post
    add_column :blobs, :index, :bigint

    PostBlob.all.each do |row|
      row.blob.update!(post_id: row.post_id, index: row.index)
    end
  end
end
