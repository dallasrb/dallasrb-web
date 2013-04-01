# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  unless Role.find_by_name(role)
    Role.find_or_create_by_name({ :name => role }, :without_protection => true)
    puts 'role: ' << role
  end
end

puts 'ORGANIZER PROFILES'
unless Profile.find_by_name("Mark McSpadden")
  profile = Profile.create(name: "Mark McSpadden",
                         blurb: "Mark is cool, Mark is hip.",
                         twitter: "markmcspadden",
                         github: "markmcspadden",
                         email: "markmcspadden@gmail.com",
                         homepage: "http://markmcspadden.net")
  profile.make_organizer!
end

unless Profile.find_by_name("Karthik Hariharan")
  profile = Profile.create(name: "Karthik Hariharan",
                         blurb: "Karthik is cool, Karthik is hip.",
                         twitter: "hkarthik",
                         github: "hkarthik",
                         email: "kar.hariharan@gmail.com",
                         homepage: "http://hkarthik.me")
  profile.make_organizer!
end

puts "EVENT TYPES"
%w(meeting hacknight other).each do |event_type|
  unless EventType.find_by_name(event_type)
    EventType.create(:name => event_type)
  end
end

puts "PAST MEETINGS"
event_type = EventType.find_by_name("meeting")
improving = <<-EOS.gsub(/^ {6}/, '')
16633 Dallas Parkway
Suite 110
Dallas, TX 75001
EOS

unless Event.find_by_slug("so-you-want-a-content-site-running-on-ruby")
  Event.create!(title: "So you want a content site running on Ruby?",
               event_type: event_type,
               event_date: DateTime.strptime('03/05/2013 19:00', '%m/%d/%Y %H:%M'),
               venue: "Improving Enterprises",
               address: improving,
               speaker: "Chris Krailo, Garrett Heinlen, Matt Rogers, Mark McSpadden, and YOU!",
               published: true,
               rsvp_url: "http://plancast.com/p/gf9g",
               description: <<-EOS.gsub(/^ {6}/, '')
So you want a content site running on Ruby?

There's an app for that. Several actually.

Garrett Heinlen of Software Allies will show us [Refinery CMS](http://refinerycms.com).

Matt Rogers of McAfee will show us [Jekyll](http://jekyllrb.com).

Mark McSpadden of Sabre Labs will show us [GitHub Pages](http://pages.github.com) and [Heroku Static Site](https://github.com/jamiew/heroku-static-site).

And Chris Krailo of Kalkomey will fill in any gaps as they arise.

Hope to see you there!
EOS
              )
end
