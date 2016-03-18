class Word < ActiveRecord::Base
  belongs_to :category
  has_many :results
  has_many :word_answers, dependent: :destroy

  validates :content, uniqueness: true, presence: true

  scope :correct, -> (user) {joins(results: [:lesson,:word_answer]).
     where("lessons.user_id = ? and word_answers.correct = ?", user, true)}

  accepts_nested_attributes_for :word_answers, allow_destroy: true,
    reject_if: lambda {|attribute| attribute[:content].blank?}
end
