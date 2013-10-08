class UserMailer < ActionMailer::Base
	default from: "example@example.com"

	def notify_subscribers(article)
		@article = article
		subscribers = User.get_subscribers(article.categories)
		.select { |user| user.id != article.user.id }
		.map {|user| user.email }
		mail bcc: subscribers, subject: "New article in category you subscribed at"
	end
end