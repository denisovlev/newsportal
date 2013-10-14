class Article < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :categories
	has_many :comments, as: :commentable

	attr_accessible :body, :header, :preview, :category_ids, :tag_list
	attr_accessible :moderated, as: [:admin]
	accepts_nested_attributes_for :categories

	validates :header, presence: true
	validates :preview, presence: true
	validates :body, presence: true

	scope :not_moderated, where(moderated: false) 
	scope :only_moderated, where(moderated: true)
	scope :rejected, where(rejected: true)
	scope :not_rejected, where(rejected: false)
	scope :today, lambda { { conditions: ["created_at >= ?", Time.zone.now.beginning_of_day] } }

	acts_as_taggable

	class << self
	  def get_paginated_articles(page, category_id, per_page = 5)
	  	page = page || 1

		query = Article.only_moderated.includes(:categories)
		if category_id
			query = Article.joins(:categories).where(categories: {id: category_id})
		end

		return query.order('created_at DESC').page(page).per(per_page)
	  end
	end

	def set_moderated(moderated)
		update_attribute(:moderated, moderated)
		if moderated
			update_attribute(:rejected, false)
			notify_moderated
		end
	end

	def notify_moderated
		UserMailer.delay.article_accepted(self.id)
		users = User.get_subscribers(self.categories)
		users.each do |user|
		 	if user.id != self.user.id
				UserMailer.delay.notify_subscriber(self.id, user.id)
			end
		end
	end

	def reject!
		self.update_attribute(:rejected, true)
		self.save
		UserMailer.delay.article_rejected(self.id)
	end

end
