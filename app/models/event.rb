class Event < ActiveRecord::Base
  extend FriendlyId
  acts_as_gmappable :lat => 'latitude', :lng => 'longitude', :process_geocoding => :geocode?,
  :address => "address", :normalized_address => "address",
  :msg => "Sorry, not even Google could figure out where that is"

  belongs_to :event_type

  attr_accessible :venue, :address, :description, :event_date, :event_type, :event_type_id, :published, :latitude, :longitude, :rsvp_url, :speaker, :title
  friendly_id :title, use: :slugged

  validates_associated :event_type

  def geocode?
    (!address.blank? && (latitude.blank? || longitude.blank?)) || address_changed?
  end

  def self.published
    where(:published => true)
  end

  def self.most_recent(count)
    published.order("event_date desc").limit(count)
  end

  def self.past_events(event_type)
    published.where(:event_type_id => event_type.id).order("event_date desc")
  end

  # create from an existing event. Key attributes only.
  def copy
    Event.new(:venue => venue,
              :address => address,
              :event_type_id => event_type_id,
              :event_date => (event_date + 1.month))
  end

  def gmaps4rails_address
    [{:lng => longitude, :lat => latitude, :width => 10, :height => 20}].to_json
  end
end
