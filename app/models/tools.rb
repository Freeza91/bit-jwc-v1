require 'nokogiri'

class Tools

  def self.parse_login res
    doc = Nokogiri::XML.parse res.body
    doc = doc.children.children.children #document-> Envelope-> Body p doc
    p '-' * 30
    doc = doc.children.children #loginverifystudent_BResponse -> loginverifystudent_BResult
    p umcid = doc[2].text
    p contract = doc[6].text
  end

  def self.parse_study_status res
    doc = Nokogiri::XML.parse res.body

  end

  def self.parse_next_lesson res
  end

  def self.parse_exam res
  end

  def self.parse_grade res
  end

  def self.parse_today_list res
  end

  def self.parse_schedule_list res
  end

  def self.parse_news_list res
  end

  def self.parse_school_tel res
  end

  def is_right? status
  end

end