class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :authorize_book
  after_action :verify_authorized

  def index
    query = params[:query]
    if query.nil?
      @books = Book.all
    else
      @books = Book.where(name: query)

      if @books.empty?
        flash.now[:notice] = 'По вашему запросу ничего не найдено...'
      end
    end
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: 'Новый учебный материал добавлен!'
    else
      flash.now[:alert] = 'Вы неправильно заполнили поля формы!'

      render :new, status: :unprocessable_entity
    end

  end

  def edit
  end

  def update

    if @book.update(book_params)
      redirect_to @book, notice: 'Учебный материал отредактирован!'
    else
      flash.now[:alert] = 'Вы неправильно заполнили поля формы!'

      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    @book.destroy

    redirect_to books_path, notice: 'Учебный материал удалён!'
  end

  def sort
    @books = Book.order(:name)

    render "index"
  end

  private

  def book_params
    params.require(:book).permit(:name, :author, :language, :level, :description)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def authorize_book
    authorize(@book || Book)
  end
end
