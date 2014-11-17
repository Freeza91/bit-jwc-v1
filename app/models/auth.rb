require 'net/https'
require 'uri'
require 'nokogiri'
require 'open-uri'
require 'curb'

class Auth

  def initialize
    @curl = Curl::Easy.new
    @curl.enable_cookies = true
    @curl.cookiefile = '/tmp/online'
    @curl.cookiejar = '/tmp/online'
    @curl.follow_location = true
    @curl.useragent = 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.111 Safari/537.36'
    @tries = 3;
  end

  def login(username, password)
    @curl.url = Setting.login_webiste
    begin
      @curl.get
    rescue
      false
    end
    @curl.cookiefile = '/tmp/online'
    doc = Nokogiri::HTML(@curl.body)
    params = {}
    begin
      params['username'] = username
      params['password'] = password
      params['lt'] = doc.css('input[name="lt"]')[0]['value']
      params['execution'] = doc.css('input[name="execution"]')[0]['value']
      params['_eventId'] = doc.css('input[name="_eventId"]')[0]['value']
      params['rmShown'] = doc.css('input[name="rmShown"]')[0]['value']
    rescue
      if @tries != 0
        @tries -= 1
        return login(username, password)
      end
      false
    end

    form_fields = URI.encode_www_form(params)
    begin
      @curl.http_post(form_fields)
    rescue
      false
    end

    if @curl.response_code == 200
      @curl.body.force_encoding('UTF-8')
    end
    false
  end

  def download_image
    index = Settings.profile
    uri = URI index
    req = Net::HTTP::Get.new uri
    req['Cookie'] = @curl.cookie
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