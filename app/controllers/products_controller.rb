class ProductsController < ApplicationController
    before_action :authenticate_user!, except:[:show, :search]
    before_action :set_product, only: [:update, :destroy, :edit, :image_destroy]

    def index
        @products = current_user.products if user_signed_in?
    end
    
    def search
        @products = Product.search(params[:search])
    end

    def new
        @product = current_user.products.build
    end
    
    def show
        @product = Product.includes(comments: :user).find(params[:id])
    end
    
    def create
        @product = current_user.products.build(product_params)

        if @product.save
            redirect_to @product
        else
            render 'new'
        end
    end

    def update
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
        @product.destroy
    end

    def image_destroy
        attachment = @product.images.find(params[:image_id])
        attachment.purge
    end

    private 
    
    def product_params
        params.require(:product).permit(:name, :description, :user_id, :quantity, :price, :images => [])
    end

    def product_edit_params
        params.require(:product).permit(:name, :description, :user_id, :quantity, :price, :images => [])
    end

    def set_product
        @product = Product.find(params[:id])
    end

end
