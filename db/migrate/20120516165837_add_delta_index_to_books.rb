class AddDeltaIndexToBooks < ActiveRecord::Migration
	
	def up
  	add_column :books, :delta, :boolean, :default => true, :null => false
	end

	def down
  	remove_column :books, :delta
	end

end