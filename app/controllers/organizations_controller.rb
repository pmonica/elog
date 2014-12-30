class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  after_action :verify_policy_scoped, :only => :index
  after_action :verify_authorized, :except => :index

  respond_to :html

  def index
    @organizations = policy_scope(Organization)
    respond_with(@organizations)
  end

  def show
    authorize @organization
    scope_situations = policy_scope(Situation)
    situations = scope_situations.select { |s| s.organizations.include?(@organization) }
    @participations = {}
    situations.each do |situation|
      p = Participation.find_by situation_id: situation.id, organization_id: @organization.id
      @participations[p.created_at] = situation
    end
    respond_with(@organization)
  end

  def new
    authorize Organization

    @organization = Organization.new
    respond_with(@organization)
  end

  def edit
    authorize @organization
  end

  def create
    authorize Organization

    @organization = Organization.new(organization_params)
    flash[:notice] = 'Organization was successfully created.' if @organization.save
    respond_with(@organization)
  end

  def update
    authorize @organization

    flash[:notice] = 'Organization was successfully updated.' if @organization.update(organization_params)
    respond_with(@organization)
  end

  def destroy
    authorize @organization

    @organization.destroy
    respond_with(@organization)
  end

  private
    def set_organization
      @organization = Organization.find(params[:id])
    end

    def organization_params
      params.require(:organization).permit(:name, :country)
    end
end
