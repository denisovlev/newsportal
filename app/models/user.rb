class User < ActiveRecord::Base
	has_many :articles
	has_many :subscriptions
	has_many :categories, through: :subscriptions
	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable

	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me
	accepts_nested_attributes_for :subscriptions

	def self.get_subscribers(categories)
		return User.select('users.id, email').joins(:categories).where(categories: {id: categories})
	end
end
