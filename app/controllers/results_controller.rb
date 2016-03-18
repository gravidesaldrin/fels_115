class ResultsController < ApplicationController
  before_action :find_lesson

  def index
    @results = @lesson.results.paginate page: params[:page]
  end
end
