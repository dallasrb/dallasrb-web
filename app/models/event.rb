class Event < ActiveRecord::Base
  extend FriendlyId
  acts_as_gmappable

  belongs_to :event_type

  attr_accessible :address, :description, :event_date, :event_type, :event_type_id, :featured, :latitude, :longitude, :rsvp_url, :speaker, :title
  geocoded_by :address
  friendly_id :title, use: :slugged

  validates_associated :event_type
  after_validation :geocode, :if => :address_changed?

  def self.most_recent(count)
    order("event_date desc").limit(count)
  end

  def self.past_events(event_type)
    where(:event_type_id => event_type.id).order("event_date desc")
  end

  # create from an existing event. Key attributes only.
  def copy
    Event.new(:address => address, :event_type_id => event_type_id)
  end

  def gmaps4rails_address
    '[{"lng": "-96.8270373", "lat": "32.9770421", "picture": "", "width": "10", "height": "20"}]'
  end
end
