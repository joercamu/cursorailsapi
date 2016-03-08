class Api::V1::UsersController < ApplicationController
	# POST /users
	def create
		if params[:auth]
			@user = User.from_omniauth(params[:auth])
			@token = @user.tokens.create()
			render "api/v1/users/show"
		else
			render json: { error:"params auth is missing" }
		end
		
	end
end