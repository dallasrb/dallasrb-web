class EventsController < ApplicationController
  def current
    @recent_event = Event.most_recent(1).first
    redirect_to @recent_event
  end

  def index
    @events = Event.past_events
  end

  def show
    @event = Event.published.find(params[:id])
  end

  def add_rsvp
    @event = Event.find(params[:id])
    Rsvp.create(:event => @event, :user => current_user)
    redirect_to event_url(@event)
  end

  def remove_rsvp
    @event = Event.find(params[:id])
    Rsvp.where(:event_id => @event.id, :user_id => current_user.id).each do |rsvp|
      rsvp.destroy # TODO: refactor
    end
    redirect_to event_url(@event)
  end
end
