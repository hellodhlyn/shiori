class Blob < ApplicationRecord
  include UuidGeneratable
  include GlobalID::Identification

  belongs_to :post, -> { with_invisible }, required: false

  delegate :author, :visible?, to: :post

  protected

  def self.blob_attribute(key)
    define_method(key, proc { content[key.to_s] })
    define_method("#{key}=", proc { |value| content[key.to_s] = value })
  end
end
