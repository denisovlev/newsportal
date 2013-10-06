class CreateArticleCategoryTable < ActiveRecord::Migration
	def up
		create_table :articles_categories, id: false do |t|
			t.references :article
			t.references :category
		end
		add_index :articles_categories, [:article_id, :category_id]
		add_index :articles_categories, :article_id
	end

	def down
		drop_table :articles_categories
	end
end
