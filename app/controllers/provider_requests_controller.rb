class ProviderRequestsController < ApplicationController
  before_action :authenticate_user!

  def new
    if current_user.provider? || current_user.admin?
      redirect_to root_path, notice: "You are already a provider or admin."
    elsif current_user.pending?
      redirect_to root_path, notice: "Your request is already pending review."
    end
  end

  def create
    current_user.update!(provider_status: :pending)
    redirect_to root_path, notice: "Your provider request has been submitted and is pending review."
  end
end
