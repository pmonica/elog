class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sensitivities, only: [:create, :new]
  after_action :verify_authorized
  
  respond_to :html

  # def index
  #   @events = Event
  #   respond_with(@events)
  # end

  # def show
  #   respond_with(@event)
  # end

  def new
    authorize Event
    @event = Event.new
    @situation = Situation.find(params[:situation_id])
    respond_with(@situation, @event)
  end

  # Não há alterações de eventos. se há mudanças a fazer, cria-se um novo evento, ou um comantário ao evento.
  # def edit
  # end

  def create
    #authorize Event
    @situation = Situation.find(params[:situation_id])
    @event = Event.new(augmented_event_params)
    authorize @event
    @event.save

    redirect_to situation_path(@situation)
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

    def augmented_event_params
        # Ensure that the event is created with correct user and correct organization (no mistification)
        new_params = event_params.merge(situation: @situation, owner_organization: current_user.organization.id, user: current_user)
    end

    def set_sensitivities
      sensitivity_hash = Event.sensitivities
      @sensitivities = sensitivity_hash.select { |s| sensitivity_hash[s] <= sensitivity_hash[current_user.clearance] }
    end


    # def set_event
    #   @event = Event.find(params[:id])
    # end

    def event_params
      params.require(:event).permit(:title, :sensitivity, :level, :decision)
    end
end
