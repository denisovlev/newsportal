ThinkingSphinx::Index.define :article, with: :active_record do
	indexes :header
	indexes :body
	indexes :preview

	has created_at, updated_at
end