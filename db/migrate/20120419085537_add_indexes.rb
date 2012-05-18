class AddIndexes < ActiveRecord::Migration
	
	def up
		add_index :authors_books, :author_id
		add_index :authors_books, :book_id
		add_index :books_formats, :book_id
		add_index :books_formats, :format_id
		add_index :books_nested_tags, :book_id
		add_index :books_nested_tags, :nested_tag_id
	end

	def down
		remove_index :authors_books, :author_id
		remove_index :authors_books, :book_id
		remove_index :books_formats, :book_id
		remove_index :books_formats, :format_id
		remove_index :books_nested_tags, :book_id
		remove_index :books_nested_tags, :nested_tag_id
	end
end