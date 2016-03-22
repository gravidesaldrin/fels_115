class Word < ActiveRecord::Base

  belongs_to :category
  has_many :results
  has_many :word_answers, dependent: :destroy

  validates :content, uniqueness: true, presence: true
  validates :category_id, presence: true

  scope :correct, -> (user) {joins(results: [:lesson,:word_answer]).
     where("lessons.user_id = ? and word_answers.correct = ?", user, true)}

  accepts_nested_attributes_for :word_answers, allow_destroy: true,
    reject_if: lambda {|attribute| attribute[:content].blank?}

  def correct_content
    self.word_answers.select{|attribute| attribute.correct}
      .map{|attribute| attribute.content}.join(", ")
  end

  class << self
    def search_words category, current_filter, current_user
      case current_filter
      when "learned"
        self.correct current_user
      when "unlearned"
        current_user.unlearned_words category
      else
        category.words
      end
    end
  end
end
