class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        ## To permit attributes while registration i.e. sign up (app/views/devise/registrations/new.html.erb)
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone_no, :uid,:photo])

        ## To permit attributes while editing a registration (app/views/devise/registrations/edit.html.erb)
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone_no, :uid,:photo])
    end

    def after_sign_in_path_for(resource)
        if current_user.authority
            stored_location_for(resource) || authority_view_path
        else
            stored_location_for(resource) || root_path
        end
    
    end

end
