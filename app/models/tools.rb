require 'nokogiri'

class Tools

  def self.parse_login res
    doc = Nokogiri::XML.parse res.body
    doc = doc.children.children.children #document-> Envelope-> Body p doc
    p '-' * 30
    doc = doc.children.children #loginverifystudent_BResponse -> loginverifystudent_BResult
    login_infor = {}
    begin
      p umcid = doc[2].text
      login_infor['umcid'] = umcid
      p contract = doc[6].text
      login_infor['contract'] = contract
      login_infor['code'] = "succeed"
    rescue Exception
      login_infor['code'] = "faild"
    end
    login_infor
  end

  def self.parse_study_status res
    begin
      doc = Nokogiri::XML.parse res.body
      doc = doc.children.children.children #document-> Envelope-> Body
      doc = doc.children.children #loginverifystudent_BResponse -> StudyStateResultp
      person = {}
      p doc[0].children[1].text #姓名-value
      person['username'] = doc[0].children[1].text
      p doc[1].children[1].text #学号
      person['password'] = doc[1].children[1].text
      p '-' * 30
      p doc[2].children[0].text #
      p doc[2].children[1].text #性别
      person['sex'] = doc[2].children[1].text
      p '-' * 30
      p doc[3].children[1].text #学制院
      person['academy'] = doc[3].children[1].text
      p '-' * 30
      p doc[4].children[1].text #专业
      person['profession'] = doc[4].children[1].text
      p '-' * 30
      p doc[5].children[1].text #班级
      person['class_num'] = doc[5].children[1].text
      p '-' * 30
      p doc[6].children[1].text #入学时间
      person['begin_time'] = doc[6].children[1].text
      p '-' * 30
      p doc[7].children[1].text #学制
      person['period'] = doc[7].children[1].text
      p '-' * 30
      p doc[8].children[1].text #学分情况
      person['grade'] = doc[8].children[1].text
      p '-' * 30
      p doc[9].children[1].text #仍未通过课程
      person['no_grade_record'] = doc[9].children[1].text
      p '-' * 30
      p doc[10].children[1].text #曾经不及格课程总学分
      person['no_grade'] = doc[10].children[1].text
    rescue Exception
    else
    end
    person
  end

  def self.parse_next_lesson res
    doc = Nokogiri::XML.parse res.body
    doc = doc.children.children.children #document-> Envelope-> Body
    doc = doc.children.children #NexttermyLessonResponse -> NexttermyLessonResult
    p doc.size
    lession = {}
    begin
      doc.each do |e|
        sub = e.children
        p sub[0].text #课程代码
        p sub[1].text #课程名字
        lession[sub[0].text] = sub[1].text
      end
    rescue Exception
    end
    lession
  end

  def self.parse_exam res
    doc = Nokogiri::XML.parse res.body
    doc = doc.children.children.children #document-> Envelope-> Body
    doc = doc.children.children #ExamResponse -> ExamResult
    p doc.size
    exam = {}
    begin
      doc.each do |e|
        sub = e.children
        p sub[0].text #考试名字
        p sub[1].text #考试时间和地点
        exam[sub[0].text] = sub[1].text
      end
    rescue Exception
    end
    exam
  end

  def self.parse_grade res
    doc = Nokogiri::XML.parse res.body
    doc = doc.children.children.children #document-> Envelope-> Body
    doc = doc.children.children #MarkResponse -> MarkResult
    p doc.size
    grade = {}
    begin
      doc.each do |e|
        sub = e.children
        p sub[0].text #科目
        p sub[1].text #成绩
        grade[sub[0].text] = sub[1].text
      end
    rescue Exception
    end
    grade
  end

  def self.parse_today_list res
    doc = Nokogiri::XML.parse res.body
    doc = doc.children.children.children #document-> Envelope-> Body
    doc = doc.children.children #getDeptPhoneByPage_SResponse -> getDeptPhoneByPage_SResult
    list = []
    begin
      doc.each do |e|
        sub = e.children
        unless sub.nil? || sub.text.size.zero? #列表
          list << sub.text
        end
      end
    rescue Exception
    end
    list
  end

  def self.parse_schedule_list res
    doc = Nokogiri::XML.parse res.body
    doc = doc.children.children.children #document-> Envelope-> Body
    doc = doc.children.children #GetScheduleListResponse -> GetScheduleListResult
    p doc.size
    i = 0
    schedule_list = {}
    begin
      doc.each do |e|
        i += 1
        sub = e.children
        if i > 14 && !sub[0].nil?
          p sub[2].text #开始上课小节
          schedule_list['start_at_num'] = sub[2].text
          p sub[3].text #课程名字
          schedule_list['subject_name'] = sub[3].text
          p sub[4].text #老师
          schedule_list['teacher'] = sub[4].text
          p sub[5].text #地点
          schedule_list['place'] = sub[5].text
          p sub[6].text #星期
          schedule_list['week'] = sub[6].text
          p sub[7].text #上课时间
          schedule_list['start_at_time'] = sub[7].text
          p sub[9].text #班号
          schedule_list['bid'] = sub[9].text
          p sub[10].text#班名字
          schedule_list['bname'] = sub[10].text
          p sub[11].text#上课周期
          schedule_list['period'] = sub[11].text
          p "*" * 30
        end
      end
    rescue Exception
    end
    schedule_list
  end

  def self.parse_news_list res
    doc = Nokogiri::XML.parse res.body
    doc = doc.children.children.children #document-> Envelope-> Body
    doc = doc.children.children #GetNewsListResponse -> GetNewsListResult
    p doc.size
    news = {}
    begin
      doc.each do |e|
        sub = e.children
        p sub[1].text #类别
        news['category'] = sub[1].text
        p sub[3].text #标题
        news['title'] = sub[3].text
        p sub[6].text #时间
        news['time'] = sub[6].text
        p sub[7].text #简介
        news['profile'] = sub[7].text
        p sub[8].text #详情地址url
        news['url'] = sub[8].text
        p "*" * 30
      end
    rescue Exception
    end
    news
  end

  def self.parse_school_tel res
    doc = Nokogiri::XML.parse res.body
    doc = doc.children.children.children #document-> Envelope-> Body
    doc = doc.children.children #getDeptPhoneByPage_SResponse -> getDeptPhoneByPage_SResult
    tel = []
    begin
      doc.each do |e|
        sub = e.children
        unless sub.nil? || sub.text.size.zero? #电话
          tel << sub.text
        end
      end
    rescue Exception
    end
  end

  def is_right? status
  end

end