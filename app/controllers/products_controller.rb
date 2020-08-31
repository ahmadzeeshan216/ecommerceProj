class ProductsController < ApplicationController
    before_action :authenticate_user!, except:[:show]

    def index
        @products=Product.where(user_id: current_user.id)
        # current_user.products
    end
    
    def new
        @product=current_user.products.build
    end
    
    def show
        @product=Product.includes(comments: :user).find(params[:id])
    end
    
    def create
        @product = current_user.products.build(product_params)

        if @product.save
            redirect_to @product
        else
            render 'new'
        end
    end

    def edit
        @product=Product.find(params[:id])
    end

    def update
        @product=Product.find(params[:id])

        if params[:images].present?
            params[:images].each do |image|
                @product.images.attach(image)
            end
        end

        if @product.update(product_params)
            redirect_to @product
        else
            render 'edit'
        end

    end

    def destroy
        @product = Product.find(params[:id])
        @product.destroy

        respond_to do |format|
            format.js { render :destroy}
            format.html
            format.json {render json: {r: "made"}}
        end
    end

    def image_destroy
        @product=Product.find(params[:product_id])
        attachment=@product.images.find(params[:image_id])
        attachment.purge

        respond_to do |format|
            format.js { render :image_destroy}
            format.html
            format.json {render json: {r: "made"}}
        end
    end

    private 
    
    def product_params
        params.require(:product).permit(:name, :description, :user_id, :quantity, :price, :images => [])
    end

    def product_edit_params
        params.require(:product).permit(:name, :description, :user_id, :quantity, :price, :images => [])
    end

end
