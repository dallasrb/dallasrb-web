class ProfilesController < ApplicationController
  def index
    @profiles = Profile.non_organizers.order('name ASC').page(params[:page]).per(10)
  end

  def edit
    @profile = Profile.find(params[:id])
    verify_user!
  end

  def update
    @profile = Profile.find(params[:id])
    verify_user!
    if @profile.update_attributes(params[:profile])
      redirect_to [:edit, @profile], :notice => "Profile saved."
    end
  end

  private

  def verify_user!
    unless @profile.email == current_user.email
      redirect_to root_url, :alert => "Access denied."
    end
  end
end
