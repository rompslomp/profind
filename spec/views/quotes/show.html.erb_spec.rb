require 'rails_helper'

RSpec.describe "quotes/show", type: :view do
  let(:quote) { create(:quote, message: "I need help with a repair") }

  before(:each) do
    assign(:quote, quote)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/I need help with a repair/)
    expect(rendered).to match(/#{quote.service.title}/)
  end
end
