class CategoriesController < ApplicationController
	def show
		@articles = Article.joins(:categories).where(categories: {id: params[:id]})
		@category = @articles.first.categories.detect do |cat|
			cat.id.to_s == params[:id]
		end
		render 'articles/index'
	end
end