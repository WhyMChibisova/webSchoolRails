class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  before_action :authorize_event
  after_action :verify_authorized

  def index
    query = params[:query]
    if query.nil?
      @events = Event.all
    else
      @events = Event.where(name: query)

      if @events.empty?
        flash.now[:notice] = 'По вашему запросу ничего не найдено...'
      end
    end
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: 'Новое мероприятие добавлено!'
    else
      flash.now[:alert] = 'Вы неправильно заполнили поля формы!'

      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Мероприятие отредактировано!'
    else
      flash.now[:alert] = 'Вы неправильно заполнили поля формы!'

      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy

    redirect_to events_path, notice: 'Мероприятие удалено!'
  end

  def sort
    @events = Event.order(:name)

    render "index"
  end

  private
  def event_params
    params.require(:event).permit(:name, :date, :time, :place, :language, :description)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_event
    authorize(@event || Event)
  end
end
