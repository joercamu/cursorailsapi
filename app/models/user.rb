class User < ActiveRecord::Base
	validates :email, presence: true, email: true
	validates :provider, presence: true
	validates :uid, presence: true
	has_many :tokens
	def self.from_omniauth(data)
		User.where(provider:data[:provider],uid:data[:uid]).first_or_create do |user|
			user.email = data[:info][:email]
		end
	end
end
