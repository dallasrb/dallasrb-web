namespace :sort do

  desc "calculate the epic sort order for all profiles"
  task epic: :environment do
    puts "Generating Sorting Scores"
    Profile.resort_members!
  end

end