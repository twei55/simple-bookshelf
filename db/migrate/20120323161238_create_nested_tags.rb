class CreateNestedTags < ActiveRecord::Migration
  def change
    create_table :nested_tags do |t|
    	t.string :name, :null => false
    	t.integer :parent_id
      t.timestamps
    end
  end
end
