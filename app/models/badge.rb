# coding: utf-8
class Badge < ActiveRecord::Base
  belongs_to :badge_set

  attr_accessible :company, :name, :profession, :surname
  validates :name, presence: true, length: {minimum: 2, maximum: 30}
  validates :company, presence: true, length: {minimum: 3, maximum: 30}
  validates :surname, length: {minimum: 2, maximum: 30}
  validates :badge_set_id, presence: true
  validates :profession, length: {minimum: 3, maximum: 30}
end
