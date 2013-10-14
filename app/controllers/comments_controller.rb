class CommentsController < ApplicationController
	before_filter :get_parent
	before_filter :is_admin, only: [:destroy]

	def new
		@comment = @parent.comments.build
	end

	def create
		@comment = @parent.comments.build(params[:comment])
		@comment.user_id = current_user.id if user_signed_in?
		if @comment.save
			redirect_to article_path(@comment.article)
		else
			render :new
		end
	end

	def destroy
		@parent.update_attribute(:deleted, true)
		@parent.save
		respond_to do |format|
			format.html do
				if @parent.article
					redirect_to @parent.article
				else
					redirect_to @parent
				end
			end
			format.json {
				render json: true
			}
		end
		
	end

	protected

	def get_parent
		@parent = Article.find(params[:article_id]) if params[:article_id]
		@parent = Comment.find(params[:comment_id]) if params[:comment_id]

		redirect_to root_path unless defined?(@parent)
	end

	def is_admin
		current_user.admin?
	end
end