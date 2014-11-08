class TestController < ApplicationController
  def index
    Infors.exam(40689)
    render :text => "success"
  end
end
