require 'rails_helper'

RSpec.describe "quotes/show", type: :view do
  before(:each) do
    assign(:quote, Quote.create!(
      message: "MyText",
      status: 2,
      user: nil,
      service: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
