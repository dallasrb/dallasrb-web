namespace :sort do

  desc "calculate the epic sort order for all profiles"
  task epic: :environment do
    puts "Generating Sorting Scores"
    Profile.non_organizers.each do |profile|
      profile.save
    end
  end

end