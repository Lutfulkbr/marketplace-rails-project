class ProductsController < ApplicationController
    before_action :cart_session

    def index
        @category = Category.find(params[:category_id])
        @products = @category.products.order(:title)
    end

    def add_to_cart
        session[:cart] << params[:id]
    end

    private

    def cart_session
        session[:cart] ||= []
    end

end
