class Comment < ActiveRecord::Base
	belongs_to :commentable, polymorphic: true
	has_many :comments, as: :commentable

  	attr_accessible :body, :commentable_id, :commentable_type

  	def article
  		return @article if defined?(@article)
  		@article = commentable.is_a?(Article) ? commentable : commentable.article
  	end
end
