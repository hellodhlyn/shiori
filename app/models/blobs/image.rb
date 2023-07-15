module Blobs
  class Image < Blob
    blob_attribute :url
    blob_attribute :preview_url
    blob_attribute :blurhash
    blob_attribute :caption
  end
end
