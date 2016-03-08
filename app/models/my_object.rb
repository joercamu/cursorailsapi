class MyObject < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 10 }
  validates :description, presence: true
  belongs_to :user
end
