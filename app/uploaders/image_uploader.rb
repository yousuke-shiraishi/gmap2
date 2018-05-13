class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  if Rails.env.production?
    include Cloudinary::CarrierWave
  else
    storage :file
  end
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  process resize_to_fill: [300, 300]
  def default_url
    'default.jpg'
  end
  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [100, 100]
  end
  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
