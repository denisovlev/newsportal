class AddRejectedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :rejected, :bool
  end
end
