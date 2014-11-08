require 'net/http'
require 'nokogiri'

class Infors

  def init(path, xml)
    uri = URI Settings.host
    http = Net::HTTP.new(uri.host, uri.port)
    header = {'Content-Type' => 'text/xml; charset=utf-8'}
    res = http.post(path, xml, header)
  end

  def login
    xml = Settings.login_username + Settings.login_password + Settings.login_infor
    path = Settings.service_post
    res = init(path, xml)
  end

  def get_study_status(num)
    xml = Settings.header + Settings.study_status% num + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
  end

  def next_lesson(num)
    xml = Settings.header + Settings.next_lesson% num + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
  end

  def exam(num)
    xml = Settings.header + Settings.exam% num + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
  end

  def grade(num)
    xml = Settings.header + Settings.grade% num + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
  end

  def today_list(num)
    xml = Settings.header + Settings.today_list% num + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
  end

  def schedule_list(num)
    xml = Settings.header + Settings.schedule_list% num + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
  end

  def news_list
    xml = Settings.header + Settings.news_list + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
  end

  def school_tel
    xml = Settings.header + Settings.schedule_list% 49753 + Settings.footer
    path = Settings.tel_post
    res = init(path, xml)
  end

end