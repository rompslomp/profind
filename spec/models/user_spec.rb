require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without a name" do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "is invalid without an email" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it "is invalid with a duplicate email" do
      create(:user, email: "test@example.com")
      user = build(:user, email: "test@example.com")
      expect(user).not_to be_valid
    end
  end

  describe "roles" do
    it "defaults to basic role" do
      user = create(:user)
      expect(user).to be_basic
    end

    it "can be set to provider" do
      user = create(:user, :provider)
      expect(user).to be_provider
    end

    it "can be set to admin" do
      user = create(:user, :admin)
      expect(user).to be_admin
    end
  end

  describe "provider_status" do
    it "defaults to not_requested" do
      user = create(:user)
      expect(user).to be_not_requested
    end

    it "can be set to pending" do
      user = create(:user, :pending)
      expect(user).to be_pending
    end
  end

  describe "#approved_provider?" do
    it "returns true when user is provider and approved" do
      user = create(:user, :provider)
      expect(user.approved_provider?).to be true
    end

    it "returns false when user is basic" do
      user = create(:user)
      expect(user.approved_provider?).to be false
    end

    it "returns false when provider is pending" do
      user = create(:user, role: :provider, provider_status: :pending)
      expect(user.approved_provider?).to be false
    end
  end

  describe "associations" do
    it "has many services" do
      user = create(:user, :provider)
      service1 = create(:service, user: user)
      service2 = create(:service, user: user)
      expect(user.services).to include(service1, service2)
    end

    it "has many quotes" do
      user = create(:user)
      service = create(:service)
      quote = create(:quote, user: user, service: service)
      expect(user.quotes).to include(quote)
    end
  end
end
