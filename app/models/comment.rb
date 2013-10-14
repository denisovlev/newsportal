class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :commentable, polymorphic: true
	has_many :comments, as: :commentable

  	attr_accessible :body, :commentable_id, :commentable_type

  	def article
  		return @article if defined?(@article)
  		@article = commentable.is_a?(Article) ? commentable : commentable.article
  	end

  	def author_name
  		if self.user
  			return self.user.name || "No name"
  		else
  			return "Anonymous"
  		end
  	end
end
