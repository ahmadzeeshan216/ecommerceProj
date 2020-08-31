class CommentsController < ApplicationController
    before_action :authenticate_user!
 
    
    def create
        @comment=current_user.comments.create(commentParams)
       
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


    def update
        
        @comment=Comment.find(params[:id])
       
        @comment.update(body: params[:body])
           
        respond_to do |format|
            format.js { render :update}
            format.html
            format.json {render json: {r: "made"}}
        end

    end
private

    def commentParams
        params.permit(:product_id,:body)
    end
end
