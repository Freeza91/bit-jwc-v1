#encoding: utf-8
require 'rufus-scheduler'
class Main

  def start
    #Uploader.new.upload("xxxxxxxx.jpg")
    #@s = Rufus::Scheduler.new
    left = 40715#Settings.student_num_start.to_i
    right = 40755#Settings.student_num_end.to_i

    left.upto(right)do |i|
      sleep(2)
      begin
        person = Infors.get_study_status i
        login_infor = Infors.login(person['username'], person['password'])
        lession = Infors.next_lesson i
        exmp = Infors.exam i
        grade = Infors.grade i
        list = Infors.today_list i
        schedule = Infors.schedule_list i
      rescue Exception
        sleep(5)
        p "need redo "
        redo
      else
        store_mongo(i, person, login_infor, lession, grade, schedule)
      end
    end
  end

  def store_mongo(ucmid, person, login_infor, lession, grade, schedule)
    p "username is !!!!"
    p person['username']
    pp = Person.new(ucmid: person['ucmid'],
                    name: person['username'].encode('utf-8'),
                    sex: person['sex'].to_s,
                    school_num: person[:school_num],
                    password: person['password'],
                    class_num: person['class_num'],
                    academy: person['academy'],
                    profession: person['profession'],
                    period: person['period'], grade: person['grade'],
                    no_grade: person['no_grade'],
                    no_grade_recode: person['no_grade_recode'],
                    begin_time: person['begin_time'])
    if pp.save
      lession.each do |k, v|
        pp.next_schedules << NextSchedule.new(name: k, code: v)
        pp.save
      end
    else
      p "can not save?!!!"
    end
  end
end
