class AddModeratedToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :moderated, :boolean, :null => false, :default => false
  end
end
