class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
