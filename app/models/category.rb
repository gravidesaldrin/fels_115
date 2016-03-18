class Category < ActiveRecord::Base
  TOTAL_ITEM_PER_LESSON = 20

  has_many :lessons
  has_many :words, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def start_a_lesson user
    lessons.create user_id: user.id, correct_item: 0,
      total_item: TOTAL_ITEM_PER_LESSON
  end
end
