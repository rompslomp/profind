require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "validations" do
    it "is valid with a name" do
      tag = build(:tag, name: "Electrician")
      expect(tag).to be_valid
    end

    it "is invalid without a name" do
      tag = build(:tag, name: nil)
      expect(tag).not_to be_valid
      expect(tag.errors[:name]).to include("can't be blank")
    end

    it "is invalid with a duplicate name" do
      create(:tag, name: "Plumber")
      tag = build(:tag, name: "Plumber")
      expect(tag).not_to be_valid
      expect(tag.errors[:name]).to include("has already been taken")
    end

    it "is case-insensitively unique" do
      create(:tag, name: "Electrician")
      tag = build(:tag, name: "electrician")
      expect(tag).not_to be_valid
    end
  end

  describe "associations" do
    it "has many services through service_tags" do
      tag = create(:tag)
      service = create(:service)
      service.tags << tag
      expect(tag.services).to include(service)
    end

    it "destroys service_tags when deleted" do
      tag = create(:tag)
      service = create(:service)
      service.tags << tag
      expect { tag.destroy }.to change(ServiceTag, :count).by(-1)
    end
  end
end
