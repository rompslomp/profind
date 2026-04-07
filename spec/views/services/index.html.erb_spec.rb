require 'rails_helper'

RSpec.describe "services/index", type: :view do
  before(:each) do
    assign(:tags, [])
    assign(:services, [ create(:service, title: "Plumbing Pro"), create(:service, title: "Electric Expert") ])
  end

  it "renders a list of services" do
    render
    expect(rendered).to match(/Plumbing Pro/)
    expect(rendered).to match(/Electric Expert/)
  end
end
