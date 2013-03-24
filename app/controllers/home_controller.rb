class HomeController < ApplicationController
  def index
    @users = User.all
  end

  def team
    @members = Member.organizers
  end
end
