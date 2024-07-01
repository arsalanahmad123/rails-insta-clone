class RegistrationsController < ApplicationController 
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        email_or_phone?(params[:user][:email_or_phone])
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Successfully signed up!"
        else
            flash[:notice] = "#{@user.errors.full_messages.join(', ')}"
            render :new
        end
    end


    def show 
        @user = User.find(params[:id])
        @posts = @user.posts.order(created_at: :desc)
    end



    private 
    def user_params
        params.require(:user).permit(:name, :password,:username,:email_or_phone)
    end
    def email_or_phone?(input)
        if input.include?("@") # Check if input contains "@", assuming it's an email
            @user.email = input
            @user.phone = nil 
        else
            @user.phone = input
            @user.email = nil
        end
    end
end