class Profile < ActiveRecord::Base
  attr_accessible :email, :homepage, :name, :twitter, :github, :blurb, :approved, :user_id
  belongs_to :user

  before_save :epic_sorting, if: lambda { !organizer? }

  validates :name, :presence => true, :on => :update

  SHORT_BLURB_LENGTH = 85

  def organizer?
    !!self.organizer
  end

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

private
  def epic_sorting
    epic_length      = 20 + Random.rand(60)
    bio_length       = blurb.present? ? blurb.length : 0
    score            = (epic_length - bio_length).abs
    self.sort_order  = score
  end
end
