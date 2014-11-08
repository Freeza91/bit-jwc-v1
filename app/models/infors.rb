require 'net/http'
require 'settings'
require 'yaml'
require 'uri'

class Infors

  def self.init(path, xml)
    uri = URI Settings.host
    http = Net::HTTP.new(uri.host, uri.port)
    header = {'Content-Type' => 'text/xml; charset=utf-8'}
    p xml
    p http.post(path, xml, header)
  end

  def self.login
    xml = Settings.login_username + Settings.login_password + Settings.login_infor
    path = Settings.service_post
    res = init(path, xml)
    parse_login res
  end

  def self.get_study_status(num)
    xml = Settings.header + Settings.study_status % {:student_num => "#{num}"} + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
    Tools.parse_study_status res
  end

  def self.next_lesson(num)
    xml = Settings.header + Settings.next_lesson % {:student_num => num} + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
    Tools.parse_next_lesson res
  end

  def self.exam(num)
    xml = Settings.header + Settings.exam % {:student_num => num} + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
    parse_exam res
  end

  def self.grade(num)
    xml = Settings.header + Settings.grade % {:student_num => num} + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
    parse_grade res
  end

  def self.today_list(num)
    xml = Settings.header + Settings.today_list % {:student_num => num} + Settings.footer
    path = Settings.key_post

    res = init(path, xml)
    parse_today_list res
  end

  def self.schedule_list(num)
    xml = Settings.header + Settings.schedule_list % {:student_num => num} + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
    parse_schedule_list res
  end

  def self.news_list
    xml = Settings.header + Settings.news_list + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
    parse_news_list res
  end

  def self.school_tel
    xml = Settings.header + Settings.schedule_list % {:student_num => 49753} + Settings.footer
    path = Settings['tel_post']
    res = init(path, xml)
    parse_school_tel res
  end

end