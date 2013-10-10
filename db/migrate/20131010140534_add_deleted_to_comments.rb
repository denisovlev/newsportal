class AddDeletedToComments < ActiveRecord::Migration
  def change
    add_column :comments, :deleted, :bool
  end
end
