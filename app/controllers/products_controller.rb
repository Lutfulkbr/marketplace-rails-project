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
        @product = Product.find(params[:id])
        @product.destroy!
        redirect_to category_products_path
    end

    def add_to_cart
        id = params[:id].to_i
        session[:cart][current_user.id] << id unless session[:cart][current_user.id].include?(id)
        redirect_to request.referrer
    end

    def remove_from_cart
        id = params[:id].to_i
        session[:cart][current_user.id].delete(id)
        redirect_to request.referrer
    end

    private

    def product_params
        params.require(:product).permit(:title, :description, :price, :category_ids)
    end

    def cart_session
        if logged_in?
            session[:cart] ||= {}
            session[:cart][current_user.id] ||= []
        end
    end

    def load_cart
        if logged_in?
            @cart = Product.where(id: session[:cart][current_user.id])
        end
    end

end
