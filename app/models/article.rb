class Article < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :categories
	has_many :comments, as: :commentable

	attr_accessible :body, :header, :preview, :category_ids
	accepts_nested_attributes_for :categories

	validates :header, presence: true
	validates :preview, presence: true
	validates :body, presence: true

	class << self
	  def get_paginated_articles(page, category_id, per_page = 5)
	  	page = page || 1

		query = Article.includes(:categories)
		if category_id
			query = Article.joins(:categories).where(categories: {id: category_id})
		end

		return query.order('created_at DESC').page(page).per(per_page)
	  end
	end

end
