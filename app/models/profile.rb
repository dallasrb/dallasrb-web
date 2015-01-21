class Profile < ActiveRecord::Base
  attr_accessible :email, :homepage, :name, :twitter, :github, :blurb, :approved, :user_id
  belongs_to :user

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

  def self.resort_members!
    non_organizers.each do |profile|
      profile.save_with_epic_sort
    end
  end

  def make_organizer!
    self.update_attribute(:organizer, true)
  end

  def approve!
    self.update_attribute(:approved, true)
  end

  def save_with_epic_sort(args={})
    assign_attributes(args)
    epic_sort
    save
  end

private
  def epic_sort
    return if organizer?
    score = Random.rand(20)
    score += 100 + Random.rand(20) if name.blank?
    score += Random.rand(20) if blurb.blank?
    score += Random.rand(20) if twitter.blank?
    score += Random.rand(20) if homepage.blank?
    self.sort_order = score
  end
end
