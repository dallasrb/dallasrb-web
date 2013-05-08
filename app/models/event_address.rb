class EventAddress < ActiveRecord::Base
  belongs_to :event
  attr_accessible :address, :event_id, :gmaps, :latitude, :longitude, :venue

  acts_as_gmappable :lat => 'latitude', :lng => 'longitude', :process_geocoding => :geocode?,
  :address => "address", :normalized_address => "address",
  :msg => "Sorry, not even Google could figure out where that is"

  def geocode?
    (!address.blank? && (latitude.blank? || longitude.blank?)) || address_changed?
  end

  def gmaps4rails_address
    [{:lng => longitude, :lat => latitude, :width => 10, :height => 20}].to_json
  end
end
