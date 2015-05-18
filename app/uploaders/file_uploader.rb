class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    #"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    "#{model.class.to_s.underscore}/#{model.id}"
  end

  def serializable_hash
    {
      url: self.url,
      name: self.file.identifier,
      size: self.file.size
    }
  end
end
