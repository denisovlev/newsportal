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

	scope :today, lambda { { conditions: ["created_at >= ?", Time.zone.now.beginning_of_day] } }

	def self.get_subscribers(categories)
		return User.select('users.id, email').joins(:categories).where(categories: {id: categories})
	end

	def become_admin!
		self.update_attribute(:admin, true)
	end

	def admin?
		self.admin
	end
end
