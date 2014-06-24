class Events::RsvpsController < ApplicationController
  def create
    @event = Event.find(params[:id])
    Rsvp.where(:event_id => @event, :user_id => current_user).first_or_create
    redirect_to event_url(@event)
  end

  def destroy
    @event = Event.find(params[:id])
    Rsvp.where(:event_id => @event.id, :user_id => current_user.id).destroy_all
    redirect_to event_url(@event)
  end
end