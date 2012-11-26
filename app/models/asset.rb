class Asset < ActiveRecord::Base
  attr_accessible :file, :image

  mount_uploader :image, ImageUploader
  mount_uploader :file, FileUploader
end
