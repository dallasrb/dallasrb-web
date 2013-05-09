class ProfilesController < ApplicationController
  #user must be signed in to edit the profile
  before_filter :authenticate_user!, except:[:index]
  
  def index
    @profiles = Profile.non_organizers.page(params[:page]).per(10)
  end

  def edit
    verify_user!
  end

  def update
    verify_user!
    if @profile.update_attributes(params[:profile])
      redirect_to [:edit, @profile], :notice => "Profile saved."
    end
  end

  private

  #edit/update only current user's profile
  def verify_user!
    @profile = current_user.profile
  end
end
