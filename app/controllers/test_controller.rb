class TestController < ApplicationController
  def index
    Infors.news_list#(40689)
    render :text => "success"
  end
end
