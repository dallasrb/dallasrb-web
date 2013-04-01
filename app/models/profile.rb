class Profile < ActiveRecord::Base
  attr_accessible :email, :homepage, :name, :twitter, :github, :blurb

  def self.non_organizers
    self.where(:organizer => [false, nil]).all
  end

  def self.organizers
    self.where(:organizer => true).all
  end

  def make_organizer!
    self.update_attribute(:organizer, true)
  end
end
