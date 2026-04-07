require 'rails_helper'

RSpec.describe "quotes/edit", type: :view do
  let(:quote) { create(:quote) }

  before(:each) do
    assign(:quote, quote)
  end

  it "renders the edit quote form" do
    render

    assert_select "form[action=?][method=?]", quote_path(quote), "post" do
      assert_select "textarea[name=?]", "quote[message]"
    end
  end
end
