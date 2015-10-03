require 'bcrypt'

class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    @submitted_password = params[:session][:password]
    if user.authenticate(@submitted_password)
      log_in(user)
      flash[:success] = "Logged in"
      redirect_to user
    else
      flash[:danger] = "Email/password mismatch"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private
    def log_in(user)
      session[:user_id] = user.id
    end

    def log_out
      if current_user
        session.delete(:user_id)
        @current_user = nil
        flash[:success] = "Logged out"
      else
        flash[:danger] = "Not logged in, so can't log out"
      end
    end

end
