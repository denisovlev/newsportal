class CreateDefaultAdmin < ActiveRecord::Migration
  def up
  	u = User.new email: "admin@example.com", password: "password", password_confirmation: "password"
  	u.become_admin!
  	u.save
  end
end
