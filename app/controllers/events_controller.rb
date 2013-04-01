class EventsController < ApplicationController
  def current
    @recent_event = Event.most_recent(1).first
    redirect_to @recent_event
  end

  def index
    @events = Event.past_events(EventType.find_by_name("meeting"))
  end

  def show
    @event = Event.published.find(params[:id])
  end
end
