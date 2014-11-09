class Uploader
  def upload(filename)
    Qiniu::RS.upload_file :uptoken            => upload_token,
                          :file               => "#{Rails.root}/app/assets/images/logo.jpg",
                          :bucket             => Settings.qiniu['bucket_name'],
                          :key                => filename,
                          :enable_crc32_check => false
  end

  def upload_token
    Qiniu::RS.generate_upload_token :scope => Settings.qiniu['bucket_name']
  end
end