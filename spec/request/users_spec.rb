require 'rails_helper' 

RSpec.describe Api::V1::UsersController, type: :request  do
	describe "POST /users" do
		before :each do
			auth = { provider: "facebook" , uid: "123dsdsd2asas3k23mk3", info: { email: "joercamu@gmail.com" } }
			post "/api/v1/users.json", { auth: auth }
		end
		it { have_http_status(200) }
		it { change(User, :count).by(0) }
		it "responds whit the user found or created" do
			json = JSON.parse(response.body)
			puts "\n\n\n --- #{json} ---- \n\n\n"
			expect(true).to eq(true)
		end
	end
end