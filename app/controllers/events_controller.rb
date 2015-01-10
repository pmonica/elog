class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sensitivites, only: [:edit, :new, :create]
  after_action :verify_authorized
  
  respond_to :html

  # def index
  #   @events = Event
  #   respond_with(@events)
  # end

  # def show
  #   respond_with(@event)
  # end

  # Temos o Create
  # def new
  #   authorize Event
  #   @event = Event.new
  #   respond_with(@event)
  # end

  # Não há alterações de eventos. se há mudanças a fazer, cria-se um novo evento, ou um comantário ao evento.
  # def edit
  # end

  def create
    authorize Event
    @event = Event.new(event_params)
    @event.save
    respond_with(@event)
  end

  # Não há alterações de eventos. se há mudanças a fazer, cria-se um novo evento, ou um comantário ao evento.
  # def update
  #   @event.update(event_params)
  #   respond_with(@event)
  # end

  # def destroy
  #   @event.destroy
  #   respond_with(@event)
  # end


  private

    def augmented_situation_params
        # Ensure that the event is created with correct user and correct organization (no mistification)
        new_params = event_params.merge(owner_organization: current_user.organization.id, user: current_user)
    end

    def set_sensitivites
      sensitivitiy_hash = Event.sensitivities
      @sensitivities = sensitivitiy_hash.select { |s| sensitivitiy_hash[s] <= sensitivitiy_hash[current_user.clearance] }
    end


    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :sensitivity, :level)
    end
end
