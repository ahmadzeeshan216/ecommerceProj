class CommentsController < ApplicationController
    before_action :authenticate_user!
     
    def create
        @comment=current_user.comments.create(commentParams)       
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
    end

    def update
        @comment=Comment.find(params[:id])
        @comment.update(body: params[:body])
    end
private

    def commentParams
        params.permit(:product_id,:body)
    end
end
