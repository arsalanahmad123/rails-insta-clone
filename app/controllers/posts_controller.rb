class PostsController < ApplicationController
  before_action :require_user,only: %i[new create destroy reels explore show like]
  def new 
    @post = Post.new 
    @posts = Post.all.order(created_at: :desc) 
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if params[:post][:media].present?
      if image_upload?
        @post.image.attach(params[:post][:media])
      elsif video_upload?
        @post.video.attach(params[:post][:media])
        @post.is_reel = true
      end
    end

    if @post.save 
          redirect_to profile_path(current_user)
    else
      render :new
    end

  end

  def show 
    @post = Post.find(params[:id])
    @comments = @post.comments.order(created_at: :desc)
  end 

def destroy
  @post = Post.find(params[:id])
  if @post.image.attached?
    @post.image.purge 
  elsif @post.video.attached?
    @post.video.purge
  end
   if @post.destroy 
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream:
          [ turbo_stream.replace(
            "posts",
            partial: "posts/posts",
            locals: {
              posts: Post.all.order(created_at: :desc)
            }
          ),
            turbo_stream.replace(
          "stats-show",
          partial: "pages/stats",
          locals: {
            user: current_user
          }
      )
          ]
        }
      end
   end
end

def reels 
  @pagy,@reels = pagy(Post.where(is_reel: true).order(created_at: :desc), items: 1)
  @comments = @reels.first.comments.order(created_at: :desc)
end

def explore 
  @pagy,@posts = pagy(Post.where(is_reel: false).order(created_at: :desc), items: 15)
end

def like 
  @post = Post.find(params[:id])
  current_user.like(@post)
  respond_to do |format|
    format.turbo_stream {
      render turbo_stream:
      turbo_stream.replace(
        "likes",
        partial: "posts/likes",
        locals: {
          reel: @post,
          liked_status: current_user.liked?(@post)
        }
      )
    }
  end
end 


  private

  def post_params
    params.require(:post).permit(:caption)
  end

  def image_upload?
    # Check if the uploaded file is an image
    params[:post][:media].content_type.start_with?("image/")
  end

  def video_upload?
    # Check if the uploaded file is a video
    params[:post][:media].content_type.start_with?("video/")
  end


end
