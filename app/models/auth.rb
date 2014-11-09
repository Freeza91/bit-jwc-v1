require 'net/https'
require 'uri'
require 'nokogiri'
require 'open-uri'

class Auth
  def login(username, password)
    index = Setting.login_webiste
  end

  def download_image cookie
    index = Settings.profile
    uri = URI index
    req = Net::HTTP::Get.new uri
    req['Cookie'] = cookie
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request req
    end
    body = res.body
    doc = Nokogiri::HTML(body)
    image = ""
    doc.css('img').each do |img|
      if img['width'] == "180px"
        image = "http://online.bit.edu.cn" + img['src']
      end
    end
    data=open(image){|f|f.read}
    open("#{Rails.root}/app/assets/images/logo.jpg","wb"){|f|f.write(data)}
  end
end