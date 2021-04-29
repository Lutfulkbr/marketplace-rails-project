class ApplicationController < ActionController::Base
    helper_method :logged_in?

    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
        current_user
    end

    def not_logged_in?
        !logged_in?
        redirect_to login_path
    end

end
