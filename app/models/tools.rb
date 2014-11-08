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
    doc = doc.children.children.children #document-> Envelope-> Body
    doc = doc.children.children #loginverifystudent_BResponse -> StudyStateResultp

    p doc[0].children[0].text #姓名-key
    p doc[0].children[1].text #姓名-value
    p '-' * 30
    p doc[1].children[0].text #学号
    p doc[1].children[1].text #
    p '-' * 30
    p doc[2].children[0].text #性别
    p doc[2].children[1].text #
    p '-' * 30
    p doc[3].children[0].text #学院
    p doc[3].children[1].text #
    p '-' * 30
    p doc[4].children[0].text #专业
    p doc[4].children[1].text #
    p '-' * 30
    p doc[5].children[0].text #班级
    p doc[5].children[1].text #
    p '-' * 30
    p doc[6].children[0].text #入学时间
    p doc[6].children[1].text #
    p '-' * 30
    p doc[7].children[0].text #学制
    p doc[7].children[1].text #
    p '-' * 30
    p doc[8].children[0].text #学分呢情况
    p doc[8].children[1].text #
    p '-' * 30
    p doc[9].children[0].text #仍未通过课程
    p doc[9].children[1].text #
    p '-' * 30
    p doc[10].children[0].text #曾经不及格课程总学分
    p doc[10].children[1].text #
  end

  def self.parse_next_lesson res
    doc = Nokogiri::XML.parse res.body
    doc = doc.children.children.children #document-> Envelope-> Body
    doc = doc.children.children #NexttermyLessonResponse -> NexttermyLessonResult
    p doc.size
    doc.each do |e|
    sub = e.children
      p sub[0].text #课程代码
      p sub[1].text #课程名字
    end

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