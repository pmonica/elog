class SituationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_situation, only: [:show, :edit, :update]
  before_action :set_sensitivites, only: [:edit, :new, :create]
  after_action :verify_policy_scoped, :only => :index
  after_action :verify_authorized, :except => :index

  respond_to :html

  def index
    @situations = policy_scope(Situation)

    if(params.has_key?(:f1))
      @f1=params[:f1]
    end
    if(params.has_key?(:f2))
      @f2=params[:f2]
    end
    if(params.has_key?(:f3))
      @f3=params[:f3]
    end
    if(params.has_key?(:sitfilt))
      @sitfilt_activo=params[:sitfilt]
      @sitfilt_activo.tap{|x| x.strip!}
    end
    if ( (defined?(@f1)!=nil) and (@f1 != "") and (@f1 != "0"))
        @situations = @situations.select { |s| s.tags.include?(Tag.find(@f1)) }
    end
    if ( (defined?(@f2)!=nil) and (@f2 != "") and (@f2 != "0"))
        @situations = @situations.select { |s| s.tags.include?(Tag.find(@f2)) }
    end
    if ( (defined?(@f3)!=nil) and (@f3 != "") and (@f3 != "0"))
        @situations = @situations.select { |s| s.tags.include?(Tag.find(@f3)) }
    end
    if ( (defined?(@sitfilt_activo)!=nil) and (@sitfilt_activo != "") and (@sitfilt_activo != "0"))
        @situations=@situations.select { |s| s.description.include?(@sitfilt_activo) }
    else
        @sitfilt_activo=""      
    end
    respond_with(@situations)
  end

  def show
    authorize @situation
    if(params.has_key?(:filtro))
      @filtro_activo=params[:filtro]
      @filtro_activo.tap{|x| x.strip!}
    else
      @filtro_activo=""
    end
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
                   Participating organizations: #{@situation.organizations.map { |o| o.name + ' - ' + o.country}}. Tags: #{@situation.tags.map{ |o| o.body}}. ")
        evento.save

        respond_with(@situation)
  end

  def update
    authorize @situation
   
    if params.has_key?(:situation)
       @situation.update(situation_params)
       respond_with(@situation)
    else
       # We will enter here, when deactivation is done by a P3 via the deactivation button 
       @situation.active=false
       @situation.save
       redirect_to situations_path
    end
    # Create an event to record the situation's change
     evento = Event.create(:user => current_user, :organization => current_user.organization, :decision => true,
               :situation => @situation, :sensitivity => @situation.sensitivity, :level => @situation.level, 
           :title => "Situation \"#{@situation.name}\" modified to: \"#{@situation.sensitivity}\", \"#{@situation.level}\", Active=\"#{@situation.active}\".
           Participating organizations: #{@situation.organizations.map { |o| o.name + ' - ' + o.country}}. Tags: #{@situation.tags.map{ |o| o.body}}. ")
     evento.save
     @situation.touch
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
      params.require(:situation).permit(:name, :description, :sensitivity, :active, :level, :_method, :organization_ids => [], :tag_ids => [])
    end

end
