class EventsController < ApplicationController
  def index
    @recent_event = Event.most_recent(1).first
  end

  def history
    @events = Event.past_events
  end

  def show
    @event = Event.find(params[:id])
  end
end
