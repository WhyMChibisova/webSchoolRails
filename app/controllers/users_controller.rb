class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authorize_user
  after_action :verify_authorized

  def index
    @users = User.all
  end

  def show
    @courses = @user.courses
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.student!
    end

    if @user.save
      redirect_to root_path, notice: 'Вы успешно зарегистрировались!'
    else
      flash.now[:alert] = 'Вы неправильно заполнили поля формы регистрации!'

      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to '/profile', notice: 'Данные пользователя обновлены!'
    else
      flash.now[:alert] = 'При обновлении данных возникли ошибки!'

      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    session.delete(:user_id)

    redirect_to root_path, notice: 'Пользователь удалён!'
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :name, :surname, :age, :login, :password)
  end

  def set_user
    @user = current_user
  end

  def authorize_user
    authorize(@user || User)
  end
end
