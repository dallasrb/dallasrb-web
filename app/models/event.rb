class Event < ActiveRecord::Base
  extend FriendlyId
  has_many :event_addresses

  accepts_nested_attributes_for :event_addresses, :allow_destroy => true

  belongs_to :event_type

  attr_accessible :venue, :address, :description, :event_date, :event_type, :event_type_id, :published, :latitude, :longitude, :rsvp_url, :speaker, :title, :event_addresses_attributes, :event_addresses
  friendly_id :title, use: :slugged

  validates_associated :event_type

  def self.published
    where(:published => true)
  end

  def self.most_recent(count)
    published.order("event_date desc").limit(count)
  end

  def self.past_events
    published.order("event_date desc")
  end

  # create from an existing event. Key attributes only.
  def copy
    new_event = self.dup(:include => [:event_addresses])
    new_event.event_date = event_date + 1.month

    new_event
  end
end
