require 'rufus-scheduler'
class Main

  def start
    #Uploader.new.upload("xxxxxxxx.jpg")
=begin
    @s = Rufus::Scheduler.new
    left = 40689#Settings.student_num_start.to_i
    right = left + 5
    left.upto(right)do |i|
      person = Infors.get_study_status i
      Infors.login(person['username'], person['password'])
      Infors.next_lesson i
      Infors.exam i
      Infors.grade i
      Infors.today_list i
      Infors.schedule_list i
    end
=end
  end
end