class Profile < ActiveRecord::Base
  attr_accessible :email, :homepage, :name, :twitter, :github, :blurb, :approved

  def self.approved(approved = true)
    self.where(:approved => approved)
  end

  def self.non_organizers
    self.approved.where(:organizer => [false, nil])
  end

  def self.organizers
    self.approved.where(:organizer => true)
  end

  def make_organizer!
    self.update_attribute(:organizer, true)
  end

  def approve!
    self.update_attribute(:approved, true)
  end
end
