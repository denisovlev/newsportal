class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  attr_accessible :category_id, :user_id
  validates :category_id, presence: true
  validates :user_id, presence: true
end
