class UsersController < ApplicationController

    def index
        if logged_in? && current_user.admin
            @users = User.all
        end
    end

    def show
        @user = User.find(params[:id])
        render :layout => false
    end

    def new
        @user = User.new
        render :layout => false
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
        else
            render :new
        end
    end

    def edit
        @user = User.find(params[:id])
        render :layout => false
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to user_path(@user)
        else
            render :show
        end
    end

    def destroy
        @user = User.find(params[:id])
        if @user.id == current_user.id
            @user.delete
            redirect_to root_path
        end
    end

    private
    
    def user_params
        params.require(:user).permit(:username, :email, :password, :admin)
    end

end
