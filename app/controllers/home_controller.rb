class HomeController < ApplicationController
  def index
    @users = User.all
    @current_event = Event.most_recent(1).first
  end

  def team
    @organizers = Profile.organizers
  end
end
