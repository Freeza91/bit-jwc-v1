class TestController < ApplicationController
  def index
    Infors.get_study_status(40689)
    render :text => "success"
  end
end
