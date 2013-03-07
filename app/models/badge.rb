# coding: utf-8
class Badge < ActiveRecord::Base
  belongs_to :badge_set

  attr_accessible :company, :name, :profession, :surname
  validates :name, presence: true, :length => { :minimum => 2, :maximum => 30 }
  validates :company, presence: true, :length => { :minimum => 3, :maximum => 30 }
  validates :surname, :length => { :minimum => 2, :maximum => 30 }
  validates :badge_set_id, presence: true
  validates :profession, :length => { :minimum => 3, :maximum => 30 }
  
  def self.import(file, bs)
    csv_text = File.read("public/"+file)

    line = CSV.parse(csv_text)

    line.each do |row|
      values = row[0].split("\t")

      badge = bs.badges.new(name: values[0], surname: values[1], company: values[2], profession: values[3])

      if badge.valid?    
        badge.save!
      end
    end
  end
end
