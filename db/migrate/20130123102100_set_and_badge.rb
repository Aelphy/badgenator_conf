class SetAndBadge < ActiveRecord::Migration
  def up
    create_table :badge_sets do |t|
      t.string :name
      t.string :image
      
      t.timestamps
    end

    create_table :badges do |t|
      t.string :name, :null => false 
      t.string :surname
      t.string :company
      t.string :profession
      t.integer :badge_set_id
      
      t.timestamps
    end
  end

  def down
    drop_table :badge_sets
    drop_table :badges
  end
end
