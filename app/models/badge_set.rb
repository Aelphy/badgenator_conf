class BadgeSet < ActiveRecord::Base
  attr_accessible :name

  attr_accessible :source
  attr_accessor :source

  attr_accessible :image
  attr_accessor :image

  has_many :badges, :dependent => :destroy 
  
  mount_uploader :image, ImageUploader  
  mount_uploader :source, CsvUploader
  
  validates :name, presence: true, :length => { :minimum => 2, :maximum => 50 }  
  
  before_validation :set_name
  
  after_save :check_source 
  
  private
  def set_name
    unless self.source.blank?
      self.name ||= self.source.send(:original_filename).gsub(".csv", "")
    end
  end
  
  def check_source
    unless source.blank?
      Badge.import(source.url, self)
    end

    true
  end
end
