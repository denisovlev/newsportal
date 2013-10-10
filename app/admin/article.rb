ActiveAdmin.register Article do
	scope :all, :default => true
	scope :not_moderated
	index do
		articles.each do |article|
			render partial: 'article', locals: {article: article}
		end
	end

	show :title => :header do |a|
		render partial: 'article_show', locals: {article: a}
	end

	form partial: 'article_edit'


	member_action :moderate, method: :post do
		article = Article.find(params[:id])
		article.set_moderated(true)
		redirect_to [:admin, article]
	end

	member_action :unmoderate, method: :post do
		article = Article.find(params[:id])
		article.set_moderated(false)
		redirect_to [:admin, article]
	end

	member_action :reject, method: :post do
		article = Article.find(params[:id])
		article.reject!
		redirect_to [:admin, article]
	end
end
