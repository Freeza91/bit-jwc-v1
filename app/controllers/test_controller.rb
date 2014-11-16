class TestController < ApplicationController
  def index
    GetWeekSchedule.new.get_week_schedule 5
    render :text => "success"
  end
end
