class ProductsController < ApplicationController
    before_action :cart_session
    before_action :load_cart

    def index
        @category = Category.find(params[:category_id])
        @products = @category.products.order(:title)
    end

    def new
        if params[:category_id]
            @category = Category.find_by(id: params[:category_id])
            @product = @category.products.build
        end
    end

    def create
            @category = Category.find_by(id: params[:category_id])
            @product = @category.products.build(product_params)
            if @product.save
                redirect_to category_products_path(@category)
            else
                render :new
            end
    end

    def edit
        @product = Product.find(params[:id])
    end

    def update
        product = Product.find(params[:id])
        if product.update(product_params)
            redirect_to category_products_path
        end
    end

    def destroy
        product = Product.find(params[:id])
        if product
            product.destroy
            redirect_to category_products_path
        end
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

    def product_params
        params.require(:product).permit(:title, :description, :price, :category_ids)
    end

    def cart_session
        session[:cart] || []
    end

    def load_cart
        @cart = Product.find_by(session[:cart])
    end

end
