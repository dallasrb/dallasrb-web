class Admin::ProfilesController < ApplicationController
  layout "admin"
  before_filter :authenticate_user!
  before_filter :check_user_is_admin?

  def index
    @profiles = Profile.unapproved
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.approve!
    redirect_to action: "index", :notice => "Profile approved!"
  end
end
