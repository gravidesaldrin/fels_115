class Admin::CategoriesController < AdminController
  before_action :find_category, except: [:index, :new, :create]

  def index
    @categories = Category.order(:name).paginate page: params[:page]
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def show
    @words = @category.words.paginate page: params[:page]
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".success"
      redirect_to admin_category_path @category
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:success] = t ".success"
    redirect_to admin_categories_path
  end

  private
  def find_category
    @category = Category.find  params[:id]
  end

  def category_params
    params.require(:category).permit :id, :name
  end
end
