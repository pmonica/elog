class SituationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_situation, only: [:show, :edit, :update, :destroy]
  after_action :verify_policy_scoped, :only => :index

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
    @situation = Situation.new
    respond_with(@situation)
  end

  def edit
  end

  def create
    @situation = Situation.new(situation_params)
    @situation.save
    respond_with(@situation)
  end

  def update
    @situation.update(situation_params)
    respond_with(@situation)
  end

  def destroy
    @situation.destroy
    respond_with(@situation)
  end

  private
    def set_situation
      @situation = Situation.find(params[:id])
    end

    def situation_params
      params.require(:situation).permit(:name, :description, :sensitivity, :level, :organization_ids => [])
    end
end
