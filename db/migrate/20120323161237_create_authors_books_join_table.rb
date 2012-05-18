class CreateAuthorsBooksJoinTable < ActiveRecord::Migration

	def up
    create_table :authors_books, {:id => false, :force => true} do |t|
      t.integer :author_id
      t.integer :book_id
      t.timestamps
    end
  end

  def down
    drop_table :authors_books
  end

end