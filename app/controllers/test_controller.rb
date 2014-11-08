class TestController < ApplicationController
  def index
    Infors.login("王心园", '1120123500')
    render :text => "success"
  end
end
