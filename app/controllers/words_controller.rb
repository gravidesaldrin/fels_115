class WordsController < ApplicationController
  def index
    @categories = Category.all
    if params[:category_id]
      @category = Category.find_by id: params[:category_id]
    else
      @category = Category.first
    end
    @words = Word.search_words(@category, params[:filter], current_user)
      .paginate page: params[:page]
  end
end
