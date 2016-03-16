class LessonsController < ApplicationController
  before_action :find_lesson, except: [:create]
  def create
    @category = Category.find params[:category]
    @category.start_a_lesson current_user
    redirect_to edit_lesson_path current_user.current_lesson
  end

  def edit
    @lesson.results.build
    @limit = Category::TOTAL_ITEM_PER_LESSON
    @questions = @lesson.questions current_user
  end

  def update
    if @lesson.update_attributes lesson_params
      redirect_to results_path id: @lesson.id
    else
      render :edit
    end
  end

  def show
  end

  private
  def lesson_params
    params.require(:lesson).permit :id, results_attributes:
      [:id, :word_id, :word_answer_id]
  end
end
