class Profile < ActiveRecord::Base
  attr_accessible :email, :homepage, :name, :twitter, :github, :blurb, :approved

  scope :not_approved, where(:approved => false)
  scope :approved, where(:approved => true)
  scope :non_organizers, approved.where(:organizer => [false, nil])
  scope :organizers, approved.where(:organizer => true)

  def make_organizer!
    self.update_attribute(:organizer, true)
  end

  def approve!
    self.update_attribute(:approved, true)
  end
end
