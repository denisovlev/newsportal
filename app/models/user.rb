class User < ActiveRecord::Base
	has_many :articles
	has_many :subscriptions
	has_many :categories, through: :subscriptions
	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable
	devise :omniauthable, :omniauth_providers => [:facebook]

	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :name
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

	def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
		user = User.where(:provider => auth.provider, :uid => auth.uid).first
		unless user
			user = User.create(
				name: auth.extra.raw_info.name,
				provider: auth.provider,
				uid: auth.uid,
				email: auth.info.email,
				password: Devise.friendly_token[0,20]
			)
		end
		user
	end

	def self.new_with_session(params, session)
		super.tap do |user|
			if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
				user.email = data["email"] if user.email.blank?
			end
		end
	end
end
