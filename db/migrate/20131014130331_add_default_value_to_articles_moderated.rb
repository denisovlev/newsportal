class AddDefaultValueToArticlesModerated < ActiveRecord::Migration
	def up
		change_column :articles, :rejected, :boolean, default: false
	end

	def down
		change_column :articles, :rejected, :bool, default: nil
	end
end
