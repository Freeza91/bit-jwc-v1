#encoding: utf-8
require 'rufus-scheduler'
class Main

  def start
    #Uploader.new.upload("xxxxxxxx.jpg")
    #@s = Rufus::Scheduler.new
    left = 40689#Settings.student_num_start.to_i
    right = 40790#Settings.student_num_end.to_i

    left.upto(right)do |i|
      begin
        person = Infors.get_study_status i
        sleep(0.1)
        login_infor = Infors.login(person['username'], person['school_num'])
        sleep(0.1)
        lession = Infors.next_lesson i
        sleep(0.1)
        exmp = Infors.exam i
        sleep(0.1)
        grade = Infors.grade i
        sleep(0.1)
        list = Infors.today_list i
        sleep(0.1)
        schedule = Infors.schedule_list i
      rescue Exception
        sleep(2)
        p "need redo "
        redo
      else
        store_mongo(i, person, login_infor, lession, grade, schedule)

      end
    end
  end

  def store_mongo(ucmid, person, login_infor, lession, grade, schedule)
    begin
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
      schedule.each do |hash|
        attributes = {
          name: hash['name'],
          bname: hash['bname'],
          bid: hash['bid'],
          weeknum: hash['weeknum'],
          start_at_num: hash['start_at_num'],
          start_at_time: hash['start_at_time'],
          week: hash['week'],
          classroom: hash['classroom'],
          teacher: hash['teacher']
        }
        ss = Schedule.where(attributes).first
        ss = Schedule.new(attributes) unless ss
        pp.schedules << ss
        pp.schedules.uniq!
        if pp.save
          ss.persons << pp
          ss.persons.uniq!
          if ss.save
          else
            p "can not save schedule"
          end
        end
      end
    else
      p "can not person save!!?!!!"
    end
    rescue Exception
      p "not store db"
    end
  end
end
