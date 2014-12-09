#encoding: utf-8

class Main
  include InforsHelper

  def start
    #Qiniu.new.upload("xxxxxxxx.jpg")
    #@s = Rufus::Scheduler.new
    left = 35075 #Settings.student_num_start.to_i
    right = 35077 #Settings.student_num_end.to_i
    try = 0
    flag = 0
    left.upto(right)do |i|
      p "current num is #{i}"
      if try > 5
        try = 0
        next
      end
      if flag > 3
        flag = 0
        next
      end
      begin
        person = get_study_status i
        sleep(0.1)
        if person['username'].blank?
          flag += 1
          sleep(20)
          redo
        end
        flag = 0
        login_infor = login(person['username'], person['school_num'])
        sleep(0.1)
        lession = next_lesson i
        sleep(0.1)
        exmp = exam i
        sleep(0.1)
        grade = grade i
        sleep(0.1)
        list = today_list i
        sleep(0.1)
        schedule = schedule_list i
      rescue Exception
        try += 1
        sleep(20)
        p "need redo "
        redo
      else
        try = 0
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
                    no_grade_recode: person['no_grade_record'],
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
            p "can not save schedule reason is #{ss.errors.messages}"
          end
        end
      end
    else
      p "can not person save!!?!!! reason is #{pp.errors.messages}"
    end
    rescue Exception
      p "not store db"
    end
  end
end
