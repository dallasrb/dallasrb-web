class Event < ActiveRecord::Base
  extend FriendlyId
  belongs_to :event_type

  attr_accessible :address, :description, :event_date, :event_type_id, :featured, :latitude, :longitude, :rsvp_url, :speaker, :title
  friendly_id :title, use: :slugged

  validates_associated :event_type

  def self.most_recent(count)
    order("event_date desc").limit(count)
  end

  def self.past_events
    order("event_date desc")
  end

  # create from an existing event. Key attributes only.
  def copy
    Event.new(:address => address, :event_type_id => event_type_id)
  end

end
