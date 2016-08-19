class TeamPhotoUploader < CarrierWave::Uploader::Base
  # if Rails.env.test?
    storage :file
  # else
  # This is where we config file uploading for development and production
  # end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
