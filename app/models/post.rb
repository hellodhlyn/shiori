class Post < ApplicationRecord
  belongs_to :namespace
  belongs_to :author, class_name: "User"
  delegate :site, :to => :namespace

  before_validation :generate_uuid, :on => :create

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid unless self.uuid.present?
  end
end
