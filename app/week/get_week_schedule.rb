class GetWeekSchedule #get current week schedule and drop old schedule
  def get_week_schedule(current_week)
    drop_old_schedule
    today = Time.now.strftime('%u') #1-7
    room = Classroom.new
    places = room.at_xiang | room.at_cun
    Schedule.all.each do |e|
      weeknum = e.weeknum
      num = weeknum.delete(weeknum[0]).delete(weeknum[-1])
      start_week, end_week = num.('-')
      if current_week.between?(start_week.to_i, end_week.to_i)
        && today == e.week.to_i
        place = e.classroom.split('/').last
        if places.include? place
          WeekSchedule.new(start_at_num: e.start_at_num.to_i,
                           classroom: place)
        end
      end
    end

  def drop_old_schedule
    delete_all(WeekSchedule.all.ids)
  end
end
