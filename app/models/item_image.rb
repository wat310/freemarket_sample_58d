class ItemImage < ApplicationRecord
  belongs_to :item, optional: true
  # mount_uploaders :image, ImageUploader
  # validates :image, presence: true
end
