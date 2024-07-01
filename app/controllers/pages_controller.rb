class PagesController < ApplicationController
  before_action :require_user,only: %i[insta profile editprofile update_bio update_avatar remove_avatar]
  before_action :redirect_if_user_logged_in,only: %i[home]
  def home 
  end

  def insta 
  end
  
  def profile 
    @user = current_user
    @posts = @user.posts.order(created_at: :desc)
  end

  def update_bio
    @user = current_user
    @user.bio = params[:user][:bio]
    @user.save 
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "bio",
          partial: "pages/new_bio",
          locals: {
            user: @user
          }
        )
      }
      format.html { redirect_to profile_path }
    end
  end

  def update_avatar 
    @user = current_user
    @user.avatar.attach(params[:user][:avatar])
    @user.save
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "main-body",
          partial: "pages/profile",
          locals: {
            user: @user
          }
        )
      }
      format.html { redirect_to profile_path }
    end
  end

  def remove_avatar 
    @user = current_user
    @user.avatar.purge
    @user.save
    respond_to do |format|
      format.html { redirect_to profile_path(@user) }
    end
  end

  def edit_section 
  end
  
  def update_section 
    current_user.update(edit_section_params)
    respond_to do |format|
      format.turbo_stream{
        render turbo_stream: turbo_stream.replace(
          "edit-contentarea",
          partial: "pages/edit_section"
        )
      }
      format.html { redirect_to profile_path }
    end
  end

  def professional_account 

  end

  def change_password
  end

  def update_password 
  old_password = params[:user][:oldpassword]
  new_password = params[:user][:password]

  if current_user.authenticate(old_password)
    # Check if the new password is valid (e.g., minimum length, complexity)
    if new_password.present? && new_password.length >= 6
      current_user.password = new_password
      if current_user.save
        respond_to do |format|
          format.turbo_stream {
            render turbo_stream: turbo_stream.replace(
              "edit-contentarea",
              partial: "pages/change_password"
            )
          }
          format.html { redirect_to profile_path, notice: "Password updated successfully." }
        end
      else
        # Handle case where the user's password update fails to save
        respond_to do |format|
          format.turbo_stream {
            render turbo_stream: turbo_stream.replace(
              "edit-contentarea",
              partial: "pages/change_password"
            )
          }
          format.html { redirect_to profile_path, alert: "Failed to update password. Please try again." }
        end
      end
    else
      # Handle case where the new password doesn't meet the minimum requirements
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "edit-contentarea",
            partial: "pages/change_password"
          )
        }
        format.html { redirect_to profile_path, alert: "New password should be at least 6 characters long." }
      end
    end
  else
    # Handle case where the old password is incorrect
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "edit-contentarea",
          partial: "pages/change_password"
        )
      }
      format.html { redirect_to profile_path, alert: "Incorrect current password." }
    end
  end
end



  private 

    def redirect_if_user_logged_in 
      redirect_to insta_path if logged_in?
    end

    def edit_section_params 
      params.require(:user).permit(:name, :username, :bio, :avatar,:email,:phone,:gender)
    end

end
