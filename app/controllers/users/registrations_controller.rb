class Users::RegistrationsController < Devise::RegistrationsController


	  # POST /resource
  def create
    super
  end
  protected

  def after_inactive_sign_up_path_for(resource)
    super
    # render json: { quase: 'lá' }, status: :almost_there
    # redirect_to user_confirmation_path(:user) unless user && user.confirmed?
    user = resource
 
  end

  def after_sign_up_path_for(resource)
    redirect_to root_path # Or :prefix_to_your_route
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end
  

end