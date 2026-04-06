class Admin::ProviderRequestsController < Admin::BaseController
  def index
    @users = User.pending.order(:created_at)
  end

  def approve
    @user = User.find(params[:id])
    @user.update!(provider_status: :approved, role: :provider)
    redirect_to admin_provider_requests_path, notice: "#{@user.name} approved as provider."
  end

  def reject
    @user = User.find(params[:id])
    @user.update!(provider_status: :rejected)
    redirect_to admin_provider_requests_path, notice: "#{@user.name}'s request was rejected."
  end
end
