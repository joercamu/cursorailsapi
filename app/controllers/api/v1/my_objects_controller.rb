class Api::V1::MyObjectsController < ApplicationController
	before_action :authenticate, only: [:create,:update,:destroy]
	before_action :set_object, only: [:show,:update,:destroy]
	before_action(only: [:update,:destroy]){ |ctrl| ctrl.authenticate_owner(@object.user) }
	def index
		@objects = MyObject.all
	end
	def show
		
	end
	def create
		@object = @current_user.my_objects.new(my_objects_params)
		if @object.save
			render 'api/v1/my_objects/show'
		else
			render json: { errors: @object.errors.full_messages } , status: :unprocessable_entity
		end
	end
	def update
		@object.update(my_objects_params)
		render "api/v1/my_objects/show"
	end
	def destroy
		@object.destroy
		render json: { message: "the object was destroy"}
	end
# ----------------------------------------------------------------------------------------------
	private
	
	def set_object
		@object = MyObject.find(params[:id])
	end
	def my_objects_params
		params.require(:object).permit(:title,:description,:latitude,:longitude,:reward,:name_type,:user_id)
	end

end