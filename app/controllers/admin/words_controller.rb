class Admin::WordsController < AdminController
  before_action :find_word, only: [:show, :destroy, :edit, :update]

  def index
    @words = Word.order(:content).paginate page: params[:page]
  end

  def new
    @word = Word.new
    @word.word_answers.build
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t ".success"
      redirect_back_or admin_word_path @word
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t ".success"
      redirect_back_or admin_word_path @word
    else
      render :edit
    end
  end

  def destroy
    @word.destroy
    redirect_to admin_words_path
  end

  private
  def find_word
    @word = Word.find params[:id]
  end

  def word_params
    params.require(:word).permit :id, :content, :category_id,
      word_answers_attributes: [:id, :content, :correct, :_destroy]
  end
end
