class Admin::DashboardController < Admin::BaseController
  def index
    @pending_requests = User.pending.count
    @total_providers = User.provider.count
    @total_users = User.count
    @total_services = Service.count
  end
end
