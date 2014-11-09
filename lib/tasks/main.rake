namespace :spiders do

  desc "get infors"
  task main: :environment do
    Main.new.start
  end
end