require 'rails_helper'

RSpec.describe "/services", type: :request do
  let(:provider) { create(:user, :provider) }
  let(:basic_user) { create(:user) }

  let(:valid_attributes) { { title: "Plumbing Service", description: "Expert plumbing repairs." } }
  let(:invalid_attributes) { { title: "", description: "" } }

  describe "GET /services" do
    it "returns a successful response" do
      create(:service, user: provider)
      get services_url
      expect(response).to be_successful
    end
  end

  describe "GET /services/:id" do
    it "returns a successful response" do
      service = create(:service, user: provider)
      get service_url(service)
      expect(response).to be_successful
    end
  end

  describe "GET /services/new" do
    context "when not authenticated" do
      it "redirects to sign in" do
        get new_service_url
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when authenticated as an approved provider" do
      it "returns a successful response" do
        sign_in provider
        get new_service_url
        expect(response).to be_successful
      end
    end

    context "when authenticated as a basic user" do
      it "redirects with not authorized" do
        sign_in basic_user
        get new_service_url
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST /services" do
    context "when authenticated as an approved provider" do
      before { sign_in provider }

      it "creates a new Service" do
        expect {
          post services_url, params: { service: valid_attributes }
        }.to change(Service, :count).by(1)
      end

      it "redirects to the created service" do
        post services_url, params: { service: valid_attributes }
        expect(response).to redirect_to(service_url(Service.last))
      end

      it "does not create a service with invalid params" do
        expect {
          post services_url, params: { service: invalid_attributes }
        }.not_to change(Service, :count)
        expect(response).to have_http_status(:unprocessable_content)
      end
    end

    context "when not authenticated" do
      it "redirects to sign in" do
        post services_url, params: { service: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE /services/:id" do
    context "when authenticated as the owner provider" do
      before { sign_in provider }

      it "destroys the service" do
        service = create(:service, user: provider)
        expect {
          delete service_url(service)
        }.to change(Service, :count).by(-1)
        expect(response).to redirect_to(services_path)
      end
    end

    context "when authenticated as a different provider" do
      it "denies the action" do
        other_provider = create(:user, :provider)
        service = create(:service, user: other_provider)
        sign_in provider
        delete service_url(service)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
