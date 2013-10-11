class UserMailer < ActionMailer::Base
	default from: "example@example.com"

	def notify_subscribers(article_id)
		@article = Article.find(article_id)
		subscribers = User.get_subscribers(@article.categories)
		.select { |user| user.id != @article.user.id }
		.map {|user| user.email }
		mail bcc: subscribers, subject: "New article in category you subscribed at"
	end

	def article_rejected(article_id)
		@article = Article.find(article_id)
		mail to: @article.user.email, subject: "Your article was rejected"
	end
end