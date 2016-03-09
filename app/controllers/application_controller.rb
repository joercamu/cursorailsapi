class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  # before_action :authenticate
protected
  def authenticate_owner(owner)
    if owner != @current_user
      render json: { errors: "token is does not belong" }, status: :unauthorized
      return false
    end
    true
  end
  def authenticate
  	token_str = params[:token]
  	token = Token.find_by(token: token_str)

  	if token.nil? or not token.is_valid?
  		render json: { error: "token is invalid" }, status: :unauthorized
  	else
  		@current_user = token.user
  	end
  end
end
