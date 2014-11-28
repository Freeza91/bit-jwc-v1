class GetTodaySchedule #get current week schedule and drop old schedule
  include ClassroomHelper
  include InforsHelper
  include ToolsHelper

  def get_today_schedule(current_week)
    drop_old_schedule
    today = 3#Time.now.strftime('%u') #1-7
    p places = at_xiang | at_cun
    Schedule.all.each do |e|
      weeknum = e.weeknum
      num = weeknum.delete(weeknum[0]).delete(weeknum[-1])
      start_week, end_week = num.split('-')
      if current_week.between?(start_week.to_i, end_week.to_i) && today == e.week.to_i
        place = e.classroom.split('/').last
        if places.include? place
          week_schedule = TodaySchedule.new(start_at_num: e.start_at_num.to_i,
                           classroom: place)
          if week_schedule.save
            p "save week_schedule"
          else
            p "something wrong!!"
          end
        end
      end
    end
  end

  def drop_old_schedule
    #TodaySchedule.all.destroy
  end
end
