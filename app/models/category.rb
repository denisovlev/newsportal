class Category < ActiveRecord::Base
  has_and_belongs_to_many :articles
  has_many :subscriptions
  has_many :users, through: :subscriptions
  attr_accessible :name, :category_id
  validates :name, presence: true
end
