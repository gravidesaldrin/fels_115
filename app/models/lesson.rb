class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy

  before_update :finish_lesson
  after_update :create_activity

  scope :finished , -> {where "finished_time IS NOT NULL"}

  accepts_nested_attributes_for :results, allow_destroy: true,
    reject_if: lambda {|attribute| attribute[:word_answer_id].blank?}

  def questions current_user
    questions = current_user.unlearned_words self.category
    limit = Category::TOTAL_ITEM_PER_LESSON
    if questions.count < limit
      added = self.category.words.correct(current_user).
        sample(limit - questions.count)
      questions += added
    end
    questions = questions.sample limit
  end

  def final_result
    "#{self.correct_item}/#{self.total_item}"
  end

  private
  def create_activity
    Activity.create user_id: self.user_id, action:
      "Learned #{self.correct_item} word(s) in Lesson '#{self.category.name}' -
      #{self.finished_time.strftime("(%m/%d/%Y)")}"
  end

  def finish_lesson
    self.correct_item = self.results.select{|attribute|
      attribute.word_answer.correct?}.count
    self.total_item = self.results.size
    self.finished_time = Time.now
  end
end
