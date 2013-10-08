class SubscriptionsController < ApplicationController 
	before_filter :sign_in_user

	def index
		@subscriptions = current_user.subscriptions.includes(:category)
	end

	def create
		category = Category.find(params[:category_id])
		@s = current_user.subscriptions.build(category_id: category.id)
		redirect_to root_path, :error => "Error" unless @s.save
		redirect_to(:back)
	end

	def destroy
		s = current_user.subscriptions.find(params[:id])
		s.destroy
		redirect_to(:back)
	end

	protected

	def sign_in_user
		redirect_to new_user_session_path unless user_signed_in?
	end
end