class TestController < ApplicationController
  def index
    Infors.grade(40689)
    render :text => "success"
  end
end
