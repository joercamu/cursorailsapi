FactoryGirl.define do
  factory :token do
    expires_at "2016-04-08 19:14:47"
    association :user, factory: :user
  end
end
