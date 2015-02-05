class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sensitivities, only: [:create, :new]
  after_action :verify_authorized

  respond_to :html

  # def index
  #   @comments = Comment.all
  #   respond_with(@comments)
  # end

  # def show
  #   respond_with(@comment)
  # end

  def new
    authorize Comment
    @comment = Comment.new
    @event = Event.find(params[:event_id])
    @situation=@event.situation

    respond_with(@event, @comment)
  end

  # def edit
  # end

  def create
    #authorize Comment
    @event = Event.find(params[:event_id])
    @situation=@event.situation
    @comment = Comment.new(augmented_comment_params)
    authorize @comment
    @comment.save
    @event.touch

    redirect_to situation_path(@situation)
  end

  # def update
  #   @comment.update(comment_params)
  #   respond_with(@comment)
  # end

  # def destroy
  #   @comment.destroy
  #   respond_with(@comment)
  # end

  private
    # def set_comment
    #   @comment = Comment.find(params[:id])
    # end

    def augmented_comment_params
        # Ensure that the event is created with correct user and correct organization (no mistification)
        # We must also insert the event_id, but I'm not sure how
        new_params = comment_params.merge(event: @event, owner_organization: current_user.organization.id, user: current_user)
    end

    def set_sensitivities
      sensitivity_hash =  Comment.sensitivities
      @sensitivities = sensitivity_hash.select { |s| sensitivity_hash[s] <= sensitivity_hash[current_user.clearance] }
    end

    def comment_params
      params.require(:comment).permit(:body, :sensitivity, :level)
    end
end
