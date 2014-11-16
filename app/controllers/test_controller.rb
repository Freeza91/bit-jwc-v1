class TestController < ApplicationController
  def index
    Classroom.new.get_classroom
    render :text => "success"
  end
end
