class ApplicationController < ActionController::Base

    include Pagy::Backend

    helper_method :log_in, :current_user, :logged_in?, :log_out, :require_user,:user_already_liked_post?


    def log_in(user)
        session[:user_id] = user.id
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end 

    def logged_in?
        !!current_user  
    end

    def log_out 
        session.delete(:user_id)
    end

    def require_user 
        if !logged_in?
            flash[:alert] = "You must be logged in to perform that action"
            redirect_to root_path
        end
    end


    def restrict_user 
        # redirect back to previous page if logged_in 
        if logged_in?
            redirect_back(fallback_location: insta_path, notice: "You are already logged in")
        end
    end

    def user_already_liked_post?
        Like.where(user_id: current_user.id, post_id: params[:id]).exists?
    end

end
