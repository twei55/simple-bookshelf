class CreateBooksTagsJoinTable < ActiveRecord::Migration
  
  def up
    create_table :books_nested_tags, :id => false, :force => true do |t|
      t.column :book_id, :integer
      t.column :nested_tag_id, :integer
      
      t.timestamps
    end
  end
  
  def down
    drop_table :books_nested_tags
  end
end
