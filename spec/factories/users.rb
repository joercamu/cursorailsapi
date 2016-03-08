FactoryGirl.define do
  factory :user do
    email "joercamu@gmail.com"
    name "Jonathan Cardenas"
    provider "facebook"
    uid "lknm23lñ4nñlknzdflwekrt"
    factory :dummy_user do
    	email "simmon@gmail.com"
	    name "Somon Cardenas"
	    provider "github"
	    uid "sdsadasdñlasjdoi23mlm4"
    end
    factory :sequence_user do
      sequence(:email) {|n| "person#{n}@example.com"}
      name "Somon Cardenas"
      provider "github"
      uid "sdsadasdñlasjdoi23mlm4"
    end
  end
end
