class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  respond_to :html

  def index
    authorize Tag
    @tags = policy_scope(Tag)
    respond_with(@tags)
  end

  def new
    authorize Tag
    @tag = Tag.new
    respond_with(@tag)
  end

  def create
    authorize Tag    
    @tag = Tag.new
    @tag.body=params[:body]
    @tag.save
    redirect_to(tags_index_path) and return
  end

  def edit
    authorize @tag
    respond_with(@tag)
  end


  def update
    authorize @tag
    old_body=@tag.body
    @tag.body=params[:body]
    # Produzir a lista das sitacoes que tem esse tag
    tag_id=@tag.id
    @sit_afectadas=Label.where(["tag_id = :u", { u: tag_id }])
    @sit_afectadas.each do |s|
        sit=Situation.find(s.situation_id)     
        # Create an event to record the tags's modification
        evento = Event.create(:user => current_user, :organization => current_user.organization, :decision => true,
                   :situation => sit, :sensitivity => sit.sensitivity, :level => sit.level, 
               :title => "Tag \"#{old_body}\" was modified to \"#{@tag.body}\". The situation tags were automatically updated to reflect the new name.")
        evento.save
        s.touch
    end
    @tag.save
    redirect_to(tags_index_path) and return
  end

  def destroy
    authorize @tag
    # Produzir a lista das sitacoes que tem esse tag
    tag_id=@tag.id
    @sit_afectadas=Label.where(["tag_id = :u", { u: tag_id }])
    @sit_afectadas.each do |s|
        sit=Situation.find(s.situation_id)     
        # Create an event to record the tags's deletion
        evento = Event.create(:user => current_user, :organization => current_user.organization, :decision => true,
                   :situation => sit, :sensitivity => sit.sensitivity, :level => sit.level, 
               :title => "Tag \"#{@tag.body}\" was deleted. Therefore, it was automatically removed from this situation.")
        evento.save
        s.touch
    end
    @tag.delete
    redirect_to(tags_index_path) and return
  end

private 
    def set_tag
      @tag = Tag.find(params[:id])
    end
    def tag_params
      params.require(:tag).permit(:body)
    end
end
