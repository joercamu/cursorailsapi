class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session

  before_action :set_jbuilder_defaults
  # before_action :authenticate
  
protected
def set_jbuilder_defaults
  @errors = []
end
def error!(message,status)
  @errors << message
  response.status = status
  render "api/v1/errors"
end
def errors_array!(array,status)
  @errors = @errors + array
  response.status = status
  render "api/v1/errors"
end
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
      error!("token is invalid....",:unauthorized)
  		# render json: { error: "token is invalid" }, status: :unauthorized
  	else
  		@current_user = token.user
  	end
  end
end
