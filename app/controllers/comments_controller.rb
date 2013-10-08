class CommentsController < ApplicationController
	before_filter :get_parent

	def new
		@comment = @parent.comments.build
	end

	def create
		@comment = @parent.comments.build(params[:comment])
		if @comment.save
			redirect_to article_path(@comment.article)
		else
			render :new
		end
	end

	protected

	def get_parent
		@parent = Article.find(params[:article_id]) if params[:article_id]
		@parent = Comment.find(params[:comment_id]) if params[:comment_id]

		redirect_to root_path unless defined?(@parent)
	end
end