class Rsvp < ActiveRecord::Base
  belongs_to :event, inverse_of: :rsvps
  belongs_to :user, inverse_of: :rsvps

  attr_accessible :user, :event
end