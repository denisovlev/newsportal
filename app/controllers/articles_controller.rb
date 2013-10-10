class ArticlesController < ApplicationController
	before_filter :sign_in_user, only: [:new, :edit, :create, :update]
	before_filter :belongs_to_user, only: [:edit, :update]
	before_filter :is_admin, only: [:destroy]

	def index 
		@articles = Article.get_paginated_articles(params[:page], params[:category_id])
	end

	def show
		@article = Article.find(params[:id], include: :categories)
	end

	def new
		@article = current_user.articles.new
	end

	def create
		@article = current_user.articles.new(article_params)
		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def edit
		render 'new'
	end

	def update
		@article.update_attributes(article_params)
		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def destroy
		article = Article.find(params[:id])
		article.destroy
		respond_to do |format|
			format.html { redirect_to root_path }
			format.json { render json: true }
		end
	end

	private

	def article_params
		params.require(:article).permit(:header, :preview, :body, category_ids: [])
	end

	def sign_in_user
		redirect_to new_user_session_path unless user_signed_in?
	end

	def belongs_to_user
		@article = Article.find(params[:id])
		if current_user.id != @article.user.id
			redirect_to @article, flash:  "You do not have permission to edit this article"
		end
	end

	def is_admin
		current_user.admin?
	end
end