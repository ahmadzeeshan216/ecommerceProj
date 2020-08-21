class HomeController < ApplicationController
    def index
        @products=Product.all
    end

    def search
        @products=Product.search(params[:search])
        
    end
end
