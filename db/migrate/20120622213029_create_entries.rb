class CreateEntries < ActiveRecord::Migration
  
  def up
    create_table :entries, :force => true do |t|
      t.integer :book_id
      t.integer :group_id
      t.timestamps
    end
  end

  def down
    drop_table :entries
  end

end
