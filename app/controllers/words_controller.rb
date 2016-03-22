class WordsController < ApplicationController
  def index
    @categories = Category.all
    if params[:category_id]
      @category = Category.find_by id: params[:category_id]
    else
      @category = Category.first
    end
    unless @category.blank?
      @words = Word.search_words(@category, params[:filter], current_user)
        .paginate page: params[:page]
    else
      @words = Word.paginate page: params[:page]
    end
  end
end
