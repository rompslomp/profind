require "rails_helper"

RSpec.describe QuotesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/quotes").to route_to("quotes#index")
    end

    it "routes to #show" do
      expect(get: "/quotes/1").to route_to("quotes#show", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/quotes/1").to route_to("quotes#destroy", id: "1")
    end

    it "routes to #new (nested under service)" do
      expect(get: "/services/1/quotes/new").to route_to("quotes#new", service_id: "1")
    end

    it "routes to #create (nested under service)" do
      expect(post: "/services/1/quotes").to route_to("quotes#create", service_id: "1")
    end
  end
end
