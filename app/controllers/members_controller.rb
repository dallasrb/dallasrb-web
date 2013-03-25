class MembersController < ApplicationController
  def index
    @members = Member.non_organizers
  end

  def edit
    @member = Member.find(params[:id])
    verify_user!
  end

  def update
    @member = Member.find(params[:id])
    verify_user!
    if @member.update_attributes(params[:member])
      redirect_to [:edit, @member], :notice => "Profile saved."
    end
  end

  private

  def verify_user!
    unless @member.email == current_user.email
      redirect_to root_url, :alert => "Access denied."
    end
  end
end
