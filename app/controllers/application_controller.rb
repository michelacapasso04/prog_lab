class ApplicationController < ActionController::Base
  
rescue_from CanCan::AccessDenied do |exception|
  redirect_to root_path, :alert => exception.message
  
 
end

   before_action :configure_permitted_parameters, if: :devise_controller?

   protected
 
   def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:roles_mask, :name])
   end
  
end
