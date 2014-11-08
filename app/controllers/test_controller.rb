class TestController < ApplicationController
  def index
    Infors.today_list(40689)
    render :text => "success"
  end
end
