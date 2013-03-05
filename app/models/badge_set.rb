class BadgeSet < ActiveRecord::Base
  attr_accessible :name

  attr_accessible :source
  attr_accessor :source

  attr_accessible :image
  attr_accessor :image

  has_many :badges, :dependent => :destroy 
  
  mount_uploader :image, ImageUploader
  
  
  validates :name, presence: true, :length => { :minimum => 2, :maximum => 50 }
end
