class CreateBookAuthors < ActiveRecord::Migration
  
  def up
    create_table :book_authors, :force => true do |t|
      t.integer :author_id
      t.integer :book_id
      t.timestamps
    end
  end

  def down
    drop_table :book_authors
  end

end
