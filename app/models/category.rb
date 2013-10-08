class Category < ActiveRecord::Base
  has_and_belongs_to_many :articles
  has_many :subscriptions
  has_many :users, through: :subscriptions
  attr_accessible :name, :category_id
  validates :name, presence: true

  def self.user_subscribed(user_id)
  	return Category.select("categories.id, categories.name, (NOT(subscriptions.id IS NULL)) AS subscribed, subscriptions.id AS subscription_id")
  			.joins("LEFT JOIN subscriptions ON subscriptions.category_id = categories.id AND subscriptions.user_id = #{user_id}")
  end

  def subscribed
    ActiveRecord::ConnectionAdapters::Column.value_to_boolean(self[:subscribed])
  end
end
