# encoding: utf-8
require 'carrierwave/processing/mime_types'

class IncomingFileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes

  process :set_content_type


  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    if Rails.env == "production"
      if self.model.service_name == "AML" 
        "#{ENV['CONFIG_FILE_UPLOAD_PATH']}/aml/aml_fileuploads" 
       elsif self.model.service_name == "ECOL"
        "#{ENV['CONFIG_APPROVED_FILE_UPLOAD_PATH']}/#{self.model.sc_service.code.downcase}/#{self.model.incoming_file_type.code.downcase}"
       else
        ENV['CONFIG_FILE_UPLOAD_PATH']
       end  
    else
      "uploads"
    end
  end

  def extension_white_list
    IncomingFile::ExtensionList
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end