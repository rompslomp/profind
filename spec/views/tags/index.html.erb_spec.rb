require 'rails_helper'

RSpec.describe "tags/index", type: :view do
  before(:each) do
    assign(:tags, [Tag.create!(name: "Electrician"), Tag.create!(name: "Plumber")])
  end

  it "renders a list of tags" do
    render
    expect(rendered).to match(/Electrician/)
    expect(rendered).to match(/Plumber/)
  end
end
