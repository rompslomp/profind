require 'rails_helper'

RSpec.describe "quotes/new", type: :view do
  before(:each) do
    assign(:quote, Quote.new(
      message: "MyText",
      status: 1,
      user: nil,
      service: nil
    ))
  end

  it "renders new quote form" do
    render

    assert_select "form[action=?][method=?]", quotes_path, "post" do
      assert_select "textarea[name=?]", "quote[message]"

      assert_select "input[name=?]", "quote[status]"

      assert_select "input[name=?]", "quote[user_id]"

      assert_select "input[name=?]", "quote[service_id]"
    end
  end
end
