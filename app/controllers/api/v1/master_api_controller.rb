class Api::V1::MasterApiController < ApplicationController
	
	layout "api/v1/application"

	before_action :cors_set_access_control_headers

	def cors_set_access_control_headers
		headers['Access-Control-Allow-Origin'] = "#{request.headers['origin']}"
		headers['Access-Control-Allow-Methods'] = "POST,GET,PUT,DELETE,OPTIONS"
		headers['Access-Control-Allow-Headers'] = 'Origin,Content-Type,Accept,Authorization,Token'

	end

	def xhr_options_request
		head :ok
	end
end