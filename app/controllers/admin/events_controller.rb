class Admin::EventsController < ApplicationController
  layout "admin"
  before_filter :authenticate_user!
  before_filter :check_user_is_admin?

  def index
    @events = Event.order("event_date desc")
  end

  def edit
    @event = Event.find(params[:id])
    @event.event_addresses.build if @event.event_addresses.blank?
  end

  def new
    @event = Event.new(:event_date => Time.now)
    @event.event_addresses.build if @event.event_addresses.blank?
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to [:edit, :admin, @event], :notice => "Event saved."
    else
      render :action => "new"
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to [:edit, :admin, @event], :notice => "Event saved."
    end
  end

  def copy
    existing_event = Event.find(params[:id])
    @event = existing_event.copy
    render :edit
  end

end
