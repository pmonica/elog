class SituationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_situation, only: [:show, :edit, :update, :destroy]
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

    @situation = Situation.new
    respond_with(@situation)
  end

  def edit
    authorize @situation
  end

  def create
    authorize Situation

    @situation = Situation.new(augmented_situation_params)
    @situation.save

    respond_with(@situation)
  end

  def update
    authorize @situation

    @situation.update(augmented_situation_params)
    respond_with(@situation)
  end

  def destroy
    authorize @situation

    @situation.destroy
    respond_with(@situation)
  end

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
      sensitivitiy_hash = Situation.sensitivities
      @sensitivities = sensitivitiy_hash.select { |s| sensitivitiy_hash[s] <= sensitivitiy_hash[current_user.clearance] }
    end

    def set_situation
      @situation = Situation.find(params[:id])
    end

    def situation_params
      params.require(:situation).permit(:name, :description, :sensitivity, :level, :organization_ids => [])
    end
end
