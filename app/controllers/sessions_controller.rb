class SessionsController < ApplicationController 
    before_action :restrict_user, only: [:new, :create]

    def new
    end

    def create 
        user = User.where('lower(email) = ? OR lower(username) = ?', params[:email].downcase, params[:email].downcase).first
        if user && user.authenticate(params[:password])
          log_in user 
          redirect_to insta_path, notice: "Logged in!"
        else
          flash.now[:alert] = "Incorrect email or password"
          render 'new'
        end
    end

    def destroy 
        log_out
        redirect_to root_path, alert: "Logged out!"
    end
end