class CommentsController < ApplicationController
    before_action :authenticate_user!, only:[:create, :destroy]
 
    
    def create
        @comment=current_user.comments.build(commentParams)
        @comment.save
       
        respond_to do |format|
            format.js { render :create }
            format.html
            format.json {render json: {r: "made"}}
        end

       
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy

        respond_to do |format|
            format.js { render :destroy}
            format.html
            format.json {render json: {r: "made"}}
        end
    end
private

    def commentParams
        params.permit(:product_id,:body)
    end
end
