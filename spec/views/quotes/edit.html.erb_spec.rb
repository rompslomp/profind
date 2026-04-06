require 'rails_helper'

RSpec.describe "quotes/edit", type: :view do
  let(:quote) {
    Quote.create!(
      message: "MyText",
      status: 1,
      user: nil,
      service: nil
    )
  }

  before(:each) do
    assign(:quote, quote)
  end

  it "renders the edit quote form" do
    render

    assert_select "form[action=?][method=?]", quote_path(quote), "post" do

      assert_select "textarea[name=?]", "quote[message]"

      assert_select "input[name=?]", "quote[status]"

      assert_select "input[name=?]", "quote[user_id]"

      assert_select "input[name=?]", "quote[service_id]"
    end
  end
end
