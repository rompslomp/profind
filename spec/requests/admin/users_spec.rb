require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  describe "GET /admin/users" do
    it "returns http success" do
      sign_in admin
      get admin_users_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin/users/:id" do
    it "returns http success" do
      sign_in admin
      get admin_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end
end
