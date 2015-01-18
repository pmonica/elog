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
    @editar = true
  end

  def create
    authorize Organization


    @organization = Organization.new(augmented_organization_params)

    if @organization.save
   
        salt=('a'..'z').to_a.shuffle[0,8].join
        @newautouser = User.create(:name => salt + " _#{@organization.name}_#{@organization.country}".gsub!(/\s/, ""), email: salt + " _#{@organization.name}_#{@organization.country}".gsub!(/\s/, "")+"@nodomain.com", :organization => @organization, :clearance => :Public, :role => :p1, :password => salt, :password_confirmation => salt)
        @newautouser.confirm!
        flash[:notice] = "Organization was successfully created. Read-only user created: email: " + salt + " _#{@organization.name}".gsub!(/\s/, "")+"_#{@organization.country}@nodomain.com; Password: " + salt
      
    end
    respond_with(@organization)
  end

  def update

    authorize @organization

    if params.has_key?(:organization)
       # @organization.update(organization_params)
       flash[:notice] = 'Organization was successfully updated.' if @organization.update(organization_params)
    
       # If organization deactivated, change mails, passwords and roles to all users of the deactivated organization
       if !@organization.active
           users_to_kill=User.where(organization: @organization)
           users_to_kill.map do |u|
              pass=('a'..'z').to_a.shuffle[0,20].join
              salt=('a'..'z').to_a.shuffle[0,20].join
              u.email=salt+"user_"+u.email+"_deactivated"
              u.role=0
              u.password=pass
              u.password_confirmation=pass
              u.confirm!
              u.save!

           end
       end

    end

   respond_with(@organization)
  end

  # def destroy
  #   authorize @organization
  #   if @organization.active 
  #      @organization.active=false 
  #   else
  #     @organization.active=true 
  #   end  
  #   @organization.save
  #   redirect_to organizations_path
  # end

  private
    def set_organization
      @organization = Organization.find(params[:id])
    end

    def organization_params
      params.require(:organization).permit(:name, :country, :active)
    end

    def augmented_organization_params
        # Ensure that organization is created with the right creator organization and country (of the user that created it).
        new_params = organization_params.merge(creator_org: current_user.organization.name, creator_country: current_user.organization.country)
    end

end
