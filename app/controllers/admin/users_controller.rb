  class Admin::UsersController < ApplicationController
    before_action :set_user, only: %i[show edit update destroy]
    before_action :authorize_user
    after_action :verify_authorized

    def index
      query = params[:query]
      if query.nil?
        @users = User.all
      else
        @users = User.where(login: query)

        if @users.empty?
          flash.now[:notice] = 'По вашему запросу ничего не найдено...'
        end
      end
    end

    def show
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)

      if @user.valid?
        @user.teacher!
      end

      if @user.save
        redirect_to admin_users_path, notice: 'Преподаватель успешно зарегистрирован!'
      else
        flash.now[:alert] = 'Вы неправильно заполнили поля формы!'

        render :new
      end
    end

    def edit
    end

    def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: 'Пользователь отредактирован!'
      else
        flash.now[:alert] = 'Вы неправильно заполнили поля формы!'

        render :edit
      end
    end

    def destroy
      if @user.admin?
        redirect_to admin_user_path, alert: 'Вы не можете удалить админа'
      else
        @user.destroy
        redirect_to admin_users_path, notice: 'Пользователь удалён!'
      end
    end

    def sort
      @users = User.order(:login)

      render "index"
    end

    private

    def user_params
      params.require(:user).permit(:name, :surname, :age, :login, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def authorize_user
      authorize([:admin, (@user || User)])
    end
  end
