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

puts 'ORGANIZER MEMBERS'
unless Member.find_by_name("Mark McSpadden")
  member = Member.create(name: "Mark McSpadden",
                         blurb: "Mark is cool, Mark is hip.",
                         twitter: "markmcspadden",
                         github: "markmcspadden",
                         email: "markmcspadden@gmail.com",
                         homepage: "http://markmcspadden.net")
  member.make_organizer!
end

unless Member.find_by_name("Karthik Hariharan")
  member = Member.create(name: "Karthik Hariharan",
                         blurb: "Karthik is cool, Karthik is hip.",
                         twitter: "hkarthik",
                         github: "hkarthik",
                         email: "kar.hariharan@gmail.com",
                         homepage: "http://hkarthik.me")
  member.make_organizer!
end
