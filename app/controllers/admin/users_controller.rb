class Admin::UsersController < ApplicationController
  layout "admin"
  before_filter :authenticate_user!
  before_filter :check_user_is_admin?

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to [:admin, :users]
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to [:admin, :users], :notice => "User removed."
    else
      render :index, :error => "Failed to delete user"
    end
  end

  def show
    @user = User.find(params[:id])
  end

end
