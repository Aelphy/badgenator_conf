class BadgeSet < ActiveRecord::Base
  attr_accessible :name, :source, :image

  attr_accessor :source, :image

  has_many :badges, dependent: :destroy 
  
  mount_uploader :image, ImageUploader  
  mount_uploader :source, CsvUploader
  
  validates :name, presence: true, length: {minimum: 2, maximum: 50}  
  
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
      self.badges.delete_all

      import(source.url)
    end

    true
  end
  
  def import(file)
    csv_text = File.read(File.join("public", file))

    line = CSV.parse(csv_text, col_sep: "\t")

    line.each do |row|
      badge = self.badges.new(name: row[0], surname: row[1], company: row[2], profession: row[3])

      if badge.valid?    
        badge.save!
      end
    end
  end
end
