class AddFullNameToAuthors < ActiveRecord::Migration

	def up
		add_column :authors, :full_name, :string
		add_column :authors, :full_name_reversed, :string
	end

	def down
		remove_column :authors, :full_name
		remove_column :authors, :full_name_reversed
	end

end