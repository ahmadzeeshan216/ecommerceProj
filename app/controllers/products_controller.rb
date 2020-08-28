class ProductsController < ApplicationController
    before_action :authenticate_user!, except:[:show]

    def index
        @products=Product.where(user_id: current_user.id)
    end
    
    def new
        @product=current_user.products.build
    end
    
    def show
        @product=Product.includes(comments: :user).find(params[:id])
    end
    
    def create
        @product = current_user.products.build(productParams)
        @product.serial_number = SecureRandom.uuid

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

        if @product.update(productParams)
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
        end
    end

    private def productParams
        params.require(:product).permit(:name,:description,:user_id,:quantity,:price,:images => [])
    end


end
