require 'rails_helper'

RSpec.describe "Admin::ProviderRequests", type: :request do
  let(:admin) { create(:user, :admin) }

  describe "GET /admin/provider_requests" do
    it "returns http success" do
      sign_in admin
      get admin_provider_requests_path
      expect(response).to have_http_status(:success)
    end
  end
end
