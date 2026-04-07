require 'rails_helper'

RSpec.describe "quotes/index", type: :view do
  before(:each) do
    assign(:quotes, [ create(:quote, message: "First quote message"), create(:quote, message: "Second quote message") ])
  end

  it "renders a list of quotes" do
    render
    expect(rendered).to match(/First quote message/)
    expect(rendered).to match(/Second quote message/)
  end
end
