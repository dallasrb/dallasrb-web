class ProfilesController < ApplicationController
  #user must be signed in to edit the profile
  before_filter :authenticate_user!, except:[:index]
  
  def index
    @profiles = Profile.non_organizers.page(params[:page]).per(10)
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
