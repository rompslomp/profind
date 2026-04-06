require 'rails_helper'

RSpec.describe Service, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      service = build(:service)
      expect(service).to be_valid
    end

    it "is invalid without a title" do
      service = build(:service, title: nil)
      expect(service).not_to be_valid
      expect(service.errors[:title]).to include("can't be blank")
    end

    it "is invalid without a description" do
      service = build(:service, description: nil)
      expect(service).not_to be_valid
      expect(service.errors[:description]).to include("can't be blank")
    end
  end

  describe "associations" do
    it "belongs to a user" do
      service = create(:service)
      expect(service.user).to be_a(User)
    end

    it "has many tags through service_tags" do
      service = create(:service)
      tag = create(:tag)
      service.tags << tag
      expect(service.tags).to include(tag)
    end
  end

  describe "scopes" do
    let!(:approved_provider) { create(:user, :provider) }
    let!(:pending_provider) { create(:user, role: :provider, provider_status: :pending) }
    let!(:approved_service) { create(:service, user: approved_provider) }
    let!(:pending_service) { create(:service, user: pending_provider) }

    describe ".by_approved_providers" do
      it "includes services from approved providers" do
        expect(Service.by_approved_providers).to include(approved_service)
      end

      it "excludes services from non-approved providers" do
        expect(Service.by_approved_providers).not_to include(pending_service)
      end
    end

    describe ".search_by_text" do
      let!(:electrician_service) { create(:service, title: "Electrician", description: "Wiring and repairs") }
      let!(:plumber_service) { create(:service, title: "Plumber", description: "Pipe installation") }

      it "finds services by title" do
        expect(Service.search_by_text("Electrician")).to include(electrician_service)
        expect(Service.search_by_text("Electrician")).not_to include(plumber_service)
      end

      it "finds services by description" do
        expect(Service.search_by_text("Wiring")).to include(electrician_service)
      end

      it "is case insensitive" do
        expect(Service.search_by_text("electrician")).to include(electrician_service)
      end
    end

    describe ".search_by_tag" do
      let!(:tag) { create(:tag, name: "Electrician") }
      let!(:tagged_service) { create(:service) }

      before { tagged_service.tags << tag }

      it "finds services by tag" do
        expect(Service.search_by_tag(tag.id)).to include(tagged_service)
      end
    end
  end
end
