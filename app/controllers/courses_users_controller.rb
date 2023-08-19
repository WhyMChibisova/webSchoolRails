class CoursesUsersController < ApplicationController
  before_action :set_course, only: %i[show destroy]

  def show
    current_user.courses << @course

    redirect_to courses_path, notice: 'Курс куплен!'
  end

  def destroy
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
end
