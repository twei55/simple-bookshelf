class CreateGroups < ActiveRecord::Migration
  def up
    create_table :groups do |t|
      t.string :name

      t.timestamps
    end

    add_column :users, :group_id, :integer
    add_column :admins, :group_id, :integer
  end

  def down
  	drop_table :groups
  	remove_column :users, :group_id
  	remove_column :admins, :group_id
  end
end
