class Admin::UsersController < Admin::BaseController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(:name)
  end

  def show
    @user = User.find(params[:id])
  end

  def update_role
    @user = User.find(params[:id])
    if @user.update(role: params[:role])
      redirect_to admin_user_path(@user), notice: "User role updated to #{@user.role}."
    else
      redirect_to admin_user_path(@user), alert: "Failed to update role."
    end
  end
end
