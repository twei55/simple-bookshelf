class AddConfirmableToUsers < ActiveRecord::Migration

	def up
		## Confirmable
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string # Only if using reconfirmable
	end

	def down
		remove_column :users, :confirmation_token
		remove_column :users, :confirmed_at
		remove_column :users, :confirmation_sent_at
		remove_column :users, :unconfirmed_email
	end

end