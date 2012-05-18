class RemoveAuthorsBooksJoinTable < ActiveRecord::Migration

	def up
		drop_table :authors_books
	end

	def down
		create_table :authors_books, {:id => false, :force => true} do |t|
      t.integer :author_id
      t.integer :book_id
      t.timestamps
    end
	end

end