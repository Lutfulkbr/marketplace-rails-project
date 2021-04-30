class ProductsController < ApplicationController
    before_action :cart_session
    before_action :load_cart

    def index
        @category = Category.find(params[:category_id])
        @products = @category.products.order(:title)
    end

    def add_to_cart
        id = params[:id].to_i
        session[:cart] << id unless session[:cart].include?(id)
        redirect_to request.referrer
    end

    def remove_from_cart
        id = params[:id].to_i
        session[:cart].delete(id)
        redirect_to request.referrer
    end

    private

    def cart_session
        session[:cart] ||= []
    end

    def load_cart
        @cart = Product.find(session[:cart])
    end

end
