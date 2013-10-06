class ArticlesController < ApplicationController
	def index 
		@articles = Article.get_paginated_articles(params[:page], params[:category_id])
	end

	def show
		@article = Article.find(params[:id], include: :categories)
		@categories = Category.all
	end

	def new
		if user_signed_in?
			@article = current_user.articles.new
			@categories = Category.all
		else 
			redirect_to new_user_session_path
		end
	end

	def create
		if current_user.id.to_s != params[:article][:user_id]
			#flash.keep
			redirect_to :root, :flash => { :error => "Error" }
			return
		end
		@article = current_user.articles.new(article_params)
		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	private

	def article_params
		params.require(:article).permit(:header, :preview, :body, category_ids: [])
	end
end