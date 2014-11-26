require 'net/http'
require 'settings'
require 'yaml'
require 'uri'

module InforsHelper
  include ToolsHelper

  def init(path, xml)
    uri = URI Settings.host
    http = Net::HTTP.new(uri.host, uri.port)
    header = {'Content-Type' => 'text/xml; charset=utf-8'}
    http.post(path, xml, header)
  end

  def login(username, password)
    xml =  Settings.header
    xml += Settings.login_username % {:username => username}
    xml += Settings.login_password % {:password => password}
    xml += Settings.login_infor
    xml += Settings.footer
    path = Settings.service_post
    res = init(path, xml)
    parse_login res
  end

  def get_study_status(num)
    xml = Settings.header + Settings.study_status % {:student_num => "#{num}"} + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
    parse_study_status res
  end

  def next_lesson(num)
    xml = Settings.header + Settings.next_lesson % {:student_num => num} + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
    parse_next_lesson res
  end

  def exam(num)
    xml = Settings.header + Settings.exam % {:student_num => num} + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
    parse_exam res
  end

  def grade(num)
    xml = Settings.header + Settings.grade % {:student_num => num} + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
    parse_grade res
  end

  def today_list(num)
    xml = Settings.header + Settings.today_list % {:student_num => num} + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
    parse_today_list res
  end

  def schedule_list(num)
    xml = Settings.header + Settings.schedule_list % {:student_num => num} + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
    parse_schedule_list res
  end

  def news_list
    xml = Settings.header + Settings.news_list + Settings.footer
    path = Settings.key_post
    res = init(path, xml)
    parse_news_list res
  end

  def school_tel
    xml = Settings.header + Settings.school_tel % {:student_num => 49753} + Settings.footer
    path = Settings['tel_post']
    res = init(path, xml)
    parse_school_tel res
  end

end