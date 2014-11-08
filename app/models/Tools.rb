require 'nokogiri'

class Tools

  before_action :is_right?

  def parse_login res
  end

  def parse_study_status res
    doc = Nokogiri::XML.parse resp.body
    doc = doc.children.children.children #document-> Envelope-> Body p doc
    p '-' * 30
    doc = doc.children.children #loginverifystudent_BResponse -> loginverifystudent_BResult
    p umcid = doc[2]
    p contract = doc[6]
  end

  def parse_next_lesson res
  end

  def parse_exam res
  end

  def parse_grade res
  end

  def parse_today_list res
  end

  def parse_schedule_list res
  end

  def parse_news_list res
  end

  def parse_school_tel res
  end

  def is_right? status
    begin
  end

end