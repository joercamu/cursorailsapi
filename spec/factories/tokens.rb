FactoryGirl.define do
  factory :token do
    expires_at ""
    user nil
    token "MyString"
  end
end
