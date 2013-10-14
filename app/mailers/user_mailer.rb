class UserMailer < ActionMailer::Base
	default from: "example@example.com"

	def notify_subscriber(article_id, subscriber_id)
		@article = Article.find(article_id)
		@subscriber = User.find(subscriber_id)
		mail to: @subscriber.email, subject: "New article in category you subscribed at"
	end

	def article_rejected(article_id)
		@article = Article.find(article_id)
		mail to: @article.user.email, subject: "Your article rejected"
	end

	def article_accepted(article_id)
		@article = Article.find(article_id)
		mail to: @article.user.email, subject: "Your article accepted"
	end
end