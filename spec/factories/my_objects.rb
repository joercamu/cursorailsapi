FactoryGirl.define do
  factory :my_object do
    title "SAMSUNG GALAXY S5 "
    description "lo encontre tirado en una silla en la disco "
    latitude 1.5
    longitude 1.5
    reward 1.5
    name_type "perdido"
    association :user, factory: :sequence_user
  end
end
