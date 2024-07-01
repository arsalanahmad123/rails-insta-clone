class CommentsController < ApplicationController 
    before_action :require_user, only: [:create]

    def new
        @comment = Comment.new
        @post = Post.find(params[:id])
    end

    def create 
        @post = Post.find(params[:id])
        @comment = @post.comments.build(body: params[:comment][:body], user_id: current_user.id)
        if @comment.save
            respond_to do |format|
                @comments = @post.comments.order(created_at: :desc)
                format.turbo_stream {
                    render turbo_stream: [
                     turbo_stream.replace(
                        "new-comment",
                        partial: "comments/comment",
                        locals: { comment: @comment }
                    ),
                    turbo_stream.replace(
                        "comments",
                        partial: "comments/comments",
                        locals: { comments: @comments }
                    ),
                    turbo_stream.replace(
                        "comments-count",
                        partial: "posts/comments_count",
                        locals: { post: @post }
                    )
                    ]
                }
            end
        end
    end

end