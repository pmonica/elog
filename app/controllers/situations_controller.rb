class SituationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_situation, only: [:show, :edit, :update]
  before_action :set_sensitivites, only: [:edit, :new, :create]
  after_action :verify_policy_scoped, :only => :index
  after_action :verify_authorized, :except => :index

  respond_to :html

  def index
    @situations = policy_scope(Situation)
    respond_with(@situations)
  end

  def show
    authorize @situation
    respond_with(@situation)
  end

  def new
    authorize Situation
    @organizations = policy_scope(Organization)
    @situation = Situation.new
    respond_with(@situation)
  end

  def edit
    authorize @situation
    @editar = true
  end

  def create
    authorize Situation

    @situation = Situation.new(augmented_situation_params)
    @situation.save

    # Create an event to record the situation's creation
    evento = Event.create(:user => current_user, :organization => current_user.organization, :decision => true,
             :situation => @situation, :sensitivity => @situation.sensitivity, :level => @situation.level,
             :title => "Situation \"#{@situation.name}\" created as \"#{@situation.sensitivity}\", \"#{@situation.level}\".
             Participating organizations: #{@situation.organizations.map { |o| o.name + ' - ' + o.country}} ")
    evento.save

    respond_with(@situation)
  end

  def update
    authorize @situation

    if params.has_key?(:situation)
       @situation.update(situation_params)
       respond_with(@situation)
       # Create an event to record the situation's change
       evento = Event.create(:user => current_user, :organization => current_user.organization, :decision => true,
                 :situation => @situation, :sensitivity => @situation.sensitivity, :level => @situation.level,
             :title => "Situation \"#{@situation.name}\" modified to \"#{@situation.sensitivity}\", \"#{@situation.level}\".
             Participating organizations: #{@situation.organizations.map { |o| o.name + ' - ' + o.country}} ")
       evento.save
    else
       # Create an event to record the deactivation
       evento = Event.create(:user => current_user, :organization => current_user.organization, :decision => true,
                 :situation => @situation, :sensitivity => @situation.sensitivity, :level => @situation.level,
             :title => "Situation \"#{@situation.name}\" deactived. Was \"#{@situation.sensitivity}\", \"#{@situation.level}\".
             Participating organizations: #{@situation.organizations.map { |o| o.name + ' - ' + o.country}} ")
       evento.save
       @situation.active=false
       @situation.save
       redirect_to situations_path
    end

  end

  # def destroy
  #   authorize @situation
  #   @situation.destroy
  #   respond_with(@situation)
  # end

  private
    def augmented_situation_params

        # Ensure that situation is created with the right owner organization (of the user that created it), and the right user
        new_params = situation_params.merge(owner_organization: current_user.organization.id, user: current_user)

        # # Ensure that the user's organization is included as a participant
        new_params[:organization_ids] = [] if new_params[:organization_ids].nil?

        unless new_params[:organization_ids].include?(current_user.organization.id.to_s)
          new_params[:organization_ids] << current_user.organization.id.to_s

        end

        new_params

    end

    def set_sensitivites
      sensitivity_hash = Situation.sensitivities
      @sensitivities = sensitivity_hash.select { |s| sensitivity_hash[s] <= sensitivity_hash[current_user.clearance] }
    end

    def set_situation
      @situation = Situation.find(params[:id])
    end

    def situation_params
      params.require(:situation).permit(:name, :description, :sensitivity, :active, :level, :_method, :organization_ids => [])
    end

end
