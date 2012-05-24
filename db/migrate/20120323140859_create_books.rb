class CreateBooks < ActiveRecord::Migration
  def up
    create_table :books, :options => "ENGINE=MyISAM"  do |t|
      t.string :title, :null => false
      t.string :year, :null => false
      t.string :publisher, :null => false
      t.text :abstract
      t.text :location
      t.boolean :publisher_is_author

      t.timestamps
    end
  end

  def down
    drop_table :books
  end
end
