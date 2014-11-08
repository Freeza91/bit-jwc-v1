class TestController < ApplicationController
  def index
    Infors.next_lesson(40689)
    render :text => "success"
  end
end
