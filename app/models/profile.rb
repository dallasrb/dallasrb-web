class Profile < ActiveRecord::Base
  attr_accessible :email, :homepage, :name, :twitter, :github, :blurb, :approved

  def self.approved
    self.where(:approved => true)
  end

  def self.unapproved
    self.where(:approved => [false, nil])
  end

  def self.non_organizers
    self.approved.where(:organizer => [false, nil])
  end

  def self.organizers
    self.approved.where(:organizer => true).order("sort_order asc")
  end

  def make_organizer!
    self.update_attribute(:organizer, true)
  end

  def approve!
    self.update_attribute(:approved, true)
  end
end
