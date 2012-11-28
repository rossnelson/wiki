class Asset < ActiveRecord::Base
  attr_accessible :file, :image

  mount_uploader :image, ImageUploader
  mount_uploader :file, FileUploader

  def success
    true
  end

  def mime_type
    extname = File.extname(file_identifier)[1..-1]
    mime_type = Mime::Type.lookup_by_extension(extname)
    content_type = mime_type.to_s unless mime_type.nil?
    content_type.split('/')
  end

  def url
    file.url
  end

  def to_builder
    asset = Jbuilder.new

    asset.(self, :id, :success, :url, :file_identifier)
    asset.image true if self.mime_type[0] == 'image'
    asset.file true unless self.mime_type[0] == 'image'

    asset
  end

end
