class CreateBooksFormatsJoinTable < ActiveRecord::Migration
  
  def up
    create_table :books_formats, :id => false, :force => true do |t|
      t.column :book_id, :integer
      t.column :format_id, :integer

      t.timestamps
    end
  end

  def down
    drop_table :books_formats
  end
  
end