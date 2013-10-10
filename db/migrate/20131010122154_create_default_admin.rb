class CreateDefaultAdmin < ActiveRecord::Migration
  def up
  	u = User.create! email: "admin@example.com", password: "password"
  	u.become_admin!
  end
end
