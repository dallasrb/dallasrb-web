class Admin::UsersController < ApplicationController
  layout "admin"
  before_filter :authenticate_user!
  before_filter :check_user_is_admin?

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to :index, :notice => "User removed."
    else
      render :index, :error => "Failed to delete user"
    end
  end

  def show
    @user = User.find(params[:id])
  end

end
