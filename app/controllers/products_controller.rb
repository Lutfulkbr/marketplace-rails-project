class ProductsController < ApplicationController
    before_action :set_product, only: [:edit, :update, :destroy]
    before_action :find_category, only: [:index, :create]
    before_action :cart_session
    before_action :load_cart

    def index
        @products = @category.products.alpha_product
    end

    def new
        if params[:category_id]
            find_category
            @product = @category.products.build
        end
    end

    def create
            @product = @category.products.build(product_params)
            if @product.save
                redirect_to category_products_path(@category)
            else
                render :new
            end
    end

    def edit
    end

    def update
        if @product.update(product_params)
            redirect_to category_products_path
        end
    end

    def destroy
        @product.destroy!
        redirect_to category_products_path
    end

    def add_to_cart
        id = params[:id].to_i

        existing_item = session[:cart][current_user.id].find { |item| item['id'] == id }
        if existing_item.present?
          existing_item['quantity'] += 1
        else
          new_item = { id: id, quantity: 1 }
          session[:cart][current_user.id] << new_item
        end
        redirect_to request.referrer
    end

    def remove_from_cart
        id = params[:id].to_i
        existing_item = session[:cart][current_user.id].find { |item| item['id'] == id }
        session[:cart][current_user.id].delete(existing_item)
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
          @cart = []
          session[:cart][current_user.id].each do |cart_item|
            product = Product.find(cart_item['id'])
            product.quantity = cart_item['quantity']
            @cart << product
          end
        end
    end

    def find_category
        @category = Category.find_by(id: params[:category_id])
    end

    def set_product
        @product = Product.find(params[:id])
    end

end
