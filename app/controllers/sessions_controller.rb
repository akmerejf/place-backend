# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  
  def create
    user = User.find_by(email: sign_in_params[:email])

    if user && !user.confirmed?
        render json: { errors: { 'Por favor, confirme seu email' => ['para continuar']}, status: 418},
          status: :unprocessable_entity #and return
    
    elsif user && user.valid_password?(sign_in_params[:password])
      @current_user = user

    else
      render json: { errors: { 'email ou senha' => ['inválidos'] } }, status: :unprocessable_entity
    end
  end
end
