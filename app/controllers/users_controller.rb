class UsersController < ApplicationController
  before_action :admin_user, only: :destroy
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      flash[:danger] = @user.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome!"
      redirect_to @user
    else
      flash[:danger] = @user.errors.full_messages
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def admin_user
      if !current_user.try(:admin?)
        flash[:danger] = "Only admins can delete users"
        redirect_to root_url unless current_user.try(:admin?)
      end
    end

    def correct_user
      if current_user != User.find(params[:id])
        flash[:danger] = "You can only edit your own profile"
        redirect_to current_user
      end
    end

end
