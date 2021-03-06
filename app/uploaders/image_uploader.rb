class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  # 画像調整
  process resize_to_fit: [800, 800]
  def extension_white_list
    %w(jpg jpeg png)
  end

  # 環境ごとに保存先変更
  if Rails.env.development? || Rails.env.test?
    storage :file
  else
    storage :fog
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
