#encoding: utf-8
require 'rufus-scheduler'
class Main

  def start
    #Uploader.new.upload("xxxxxxxx.jpg")
    #@s = Rufus::Scheduler.new
    left = 40689#Settings.student_num_start.to_i
    right = 40690#Settings.student_num_end.to_i

    left.upto(right)do |i|
      begin
        person = Infors.get_study_status i
        sleep(0.2)
        login_infor = Infors.login(person['username'], person['school_num'])
        sleep(0.2)
        lession = Infors.next_lesson i
        sleep(0.2)
        exmp = Infors.exam i
        sleep(0.2)
        grade = Infors.grade i
        sleep(0.2)
        list = Infors.today_list i
        sleep(0.2)
        schedule = Infors.schedule_list i
        sleep(0.2)
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
    pp = Person.new(ucmid: ucmid,
                    name: person['username'],
                    sex: person['sex'],
                    school_num: person['school_num'],
                    class_num: person['class_num'],
                    academy: person['academy'],
                    profession: person['profession'],
                    period: person['period'],
                    grade: person['grade'],
                    no_grade: person['no_grade'],
                    no_grade_recode: person['no_grade_recode'],
                    begin_time: person['begin_time'],
                    contract: login_infor['contract'])
    if pp.save
      lession.each do |k, v|
        pp.next_schedules << NextSchedule.new(code: k, name: v)
        pp.save
      end
    else
      p "can not save?!!!"
    end
  end
end
