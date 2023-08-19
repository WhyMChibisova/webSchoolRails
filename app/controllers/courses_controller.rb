class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy buy delete_users_course]
  before_action :authorize_course
  after_action :verify_authorized

  def index
    query = params[:query]
    if query.nil?
      @courses = Course.all
    else
      @courses = Course.where(name: query)

      if @courses.empty?
        flash.now[:notice] = 'По вашему запросу ничего не найдено...'
      end
    end
  end


  def show
  end


  def new
    @course = Course.new
  end


  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to @course, notice: 'Новый курс добавлен!'
    else
      flash.now[:alert] = 'Вы неправильно заполнили поля формы!'

      render :new, status: :unprocessable_entity
    end
  end


  def edit
  end


  def update
    if @course.update(course_params)
      redirect_to @course,  notice: 'Курс отредактирован!'
    else
      flash.now[:alert] = 'Вы неправильно заполнили поля формы!'

      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @course.destroy

    redirect_to courses_path, notice: 'Курс удалён!'
  end

  def sort
    @courses = Course.order(:name)

    render "index"
  end


  def buy
    current_user.courses<< @course

    redirect_to courses_path, notice: 'Курс куплен!'
  end

  def delete_users_course
    current_user.courses.delete(@course)

    redirect_to '/profile', notice: 'Курс удалён!'
  end





  private

  def course_params
    params.require(:course).permit(:name, :language, :level, :quantity_of_students, :age_of_group, :price, :description)
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def authorize_course
    authorize(@course || Course)
  end
end
