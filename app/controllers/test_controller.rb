class TestController < ApplicationController
  include ClassroomHelper

  def index
    #classroom_init
    #get_classroom
    #Main.new.start
    #a = GetTodaySchedule.new
    #a.classroom_init
    #a.get_today_schedule(1)
    render :text => "success"
  end
end
