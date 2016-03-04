require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should_not allow_value("joercamu@gmail").for(:email) }
  it { should allow_value("joercamu@gmail.com").for(:email) }
end
