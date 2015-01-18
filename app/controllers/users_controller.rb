class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    authorize current_user
    @users = policy_scope(User)
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user

    # Change mails, passwords and role of the user
    pass=('a'..'z').to_a.shuffle[0,20].join
    salt=('a'..'z').to_a.shuffle[0,20].join
    @user.email=salt+"user_"+@user.email+"_deactivated"
    @user.role=0
    @user.password=pass
    @user.password_confirmation=pass
    @user.confirm!
    @user.save!

    redirect_to users_path, :notice => "User deactivated."
  end

  private

  def secure_params
    params.require(:user).permit(:role, :organization_id, :clearance)
  end

end
