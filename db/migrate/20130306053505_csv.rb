class Addrow < ActiveRecord::Migration
  def up
    change_table :badge_sets do |t|
      t.string :source      
    end    
  end
end
