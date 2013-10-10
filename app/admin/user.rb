ActiveAdmin.register User do
	index do
		column :id
		column :email
		column :current_sign_in_at
		column :created_at
		default_actions
	end

	form do |f|
		f.inputs "user details" do
			f.input :email
			f.input :password
			f.input :password_confirmation
		end
		f.buttons
	end
end
