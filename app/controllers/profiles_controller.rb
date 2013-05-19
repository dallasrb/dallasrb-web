class ProfilesController < ApplicationController
  #user must be signed in to edit the profile
  autocomplete :profile, :name
  before_filter :authenticate_user!, only:[:edit,:update]


  def index
    @profiles = Profile.non_organizers.order('sort_order asc').page(params[:page]).per(8)
  end

  def show
    @profile = Profile.non_organizers.find(params[:id])
  end

  def search
    begin
      @profile = Profile.non_organizers.find(params[:profile][:id])
      render :show
    rescue
      flash[:notice] = "Searched Profile not found"
      redirect_to profiles_path
    end
  end

  def edit
    verify_user!
  end

  def update
    verify_user!
    if @profile.save_with_epic_sort(params[:profile])
      redirect_to [:edit, @profile], :notice => "Profile saved."
    else
      render :edit
    end
  end

  private

  #edit/update only current user's profile
  def verify_user!
    @profile = current_user.profile
  end
end
