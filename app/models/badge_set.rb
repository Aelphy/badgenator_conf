class BadgeSet < ActiveRecord::Base
  attr_accessible :name

  attr_accessible :source
  attr_accessor :source

  attr_accessible :image
  attr_accessor :image

  has_many :badges, dependent: :destroy 
  
  mount_uploader :image, ImageUploader  
  mount_uploader :source, CsvUploader
  
  validates :name, presence: true, length: { :minimum => 2, :maximum => 50 }  
  
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
      self.badges.each do |badge|
        badge.delete
      end

      import(source.url)
    end

    true
  end
  
  def import(file)
    csv_text = File.read(File.join("public", file))

    line = CSV.parse(csv_text)

    line.each do |row|
      values = row[0].split("\t")

      badge = self.badges.new(name: values[0], surname: values[1], company: values[2], profession: values[3])

      if badge.valid?    
        badge.save!
      end
    end
  end
end
