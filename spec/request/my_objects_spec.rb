require 'rails_helper'
RSpec.describe Api::V1::MyObjectsController, type: :request do

	describe "GET /objects" do
		before :each do
			FactoryGirl.create_list(:my_object, 10)
			get "/api/v1/objects"
		end
		it { have_http_status(200) }
		it "render list objects" do 
			json = JSON.parse( response.body )
			# puts "\n\n #{json} \n\n"
			expect(json.length).to eq(MyObject.count)
		end
	end

	describe "GET /objects/:id" do
		before :each do
			@object = FactoryGirl.create(:my_object)
			get "/api/v1/objects/#{@object.id}"
		end
		it { expect(response).to have_http_status(200) }
		it "send object request" do
			json = JSON.parse(response.body)
			expect(json["id"]).to eq(@object.id)
		end
	end

	describe "POST /objects" do
		context "token is valid" do
			before :each do
				@token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes)
				post "/api/v1/objects", { token: @token.token, object: { title:"Hola mundo", description:"cualqueir cosas que seme ocuttras"} }
			end
			it { expect(response).to have_http_status(200) }
			# indica que el modelo incrento 1vez despues de la accion
			it { change(MyObject,:count).by(0) }
			it "response whit one object" do 
				json = JSON.parse(response.body)
				# puts "\n\n #{json} \n\n"
				expect(json["title"]).to eq("Hola mundo")
			end
		end

		context "token is invalid" do
			before :each do
				post "/api/v1/objects"
			end
			it { expect(response).to have_http_status(401) }

		end
		
	end

	context "invalid params for new object" do
		before :each do
			@token = FactoryGirl.create(:token, expires_at:DateTime.now + 10.minutes )
			post "/api/v1/objects", { token: @token.token, object: { title:"Hola mundo" } }
		end
		it { expect(response).to have_http_status(422) }
		it "repond whit errros at try save object" do
			json = JSON.parse(response.body)
			expect(json["errors"]).to_not be_empty
			# puts "\n\n -#{response.header}- \n\n"
		end
	end

	describe "PATCH /objects/:id" do
		context "token is valid" do
			before :each do
				@token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes)
				@object = FactoryGirl.create(:my_object, user: @token.user )
				patch api_v1_object_path(@object), { token: @token.token , object: { title: "Nuevo title" } }
			end
			it { expect(response).to have_http_status(200) }
			it "update object found" do 
				json = JSON.parse(response.body)
				# puts "\n\n -#{json}- \n\n"
				expect(json["title"]).to eq("Nuevo title")
			end
		end
		context "token is invalid" do
			before :each do
				@token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes)
				@object = FactoryGirl.create(:my_object, user: FactoryGirl.create(:dummy_user) )
				patch api_v1_object_path(@object), { token: @token.token , object: { title: "Nuevo title" } }
			end
			it { expect(response).to have_http_status(401) }
		end
	end
	describe "DELETE /objects/:id" do
		context "token is valid" do
			before :each do
				@token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes)
				@object = FactoryGirl.create(:my_object, user: @token.user )
			end
			it { 
				delete api_v1_object_path(@object), { token: @token.token }
				expect(response).to have_http_status(200) 
			}
			it "destroy object found" do 
				expect{
					delete api_v1_object_path(@object), { token: @token.token }
					}.to change(MyObject,:count).by(-1)
			end
		end
		context "token is invalid" do
			before :each do
				@token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes)
				@object = FactoryGirl.create(:my_object, user: FactoryGirl.create(:dummy_user) )
				delete api_v1_object_path(@object), { token: @token.token }
			end
			it { expect(response).to have_http_status(401) }
		end
	end
end


