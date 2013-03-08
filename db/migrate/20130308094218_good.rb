<<<<<<< HEAD:db/migrate/20130308094218_good.rb
class Good < ActiveRecord::Migration
  def up
    change_table :badge_sets do |t|
      t.string :source      
    end
=======
class Addrow < ActiveRecord::Migration
  def up
    change_table :badge_sets do |t|
      t.string :source      
    end    
>>>>>>> 1d8beada6ba3718e7a38f5d9230dd942ae13f83b:db/migrate/20130306053505_csv.rb
  end
end
