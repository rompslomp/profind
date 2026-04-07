require 'rails_helper'

RSpec.describe "quotes/new", type: :view do
  let(:service) { create(:service) }

  before(:each) do
    assign(:service, service)
    assign(:quote, Quote.new)
  end

  it "renders new quote form" do
    render

    assert_select "form[action=?][method=?]", service_quotes_path(service), "post" do
      assert_select "textarea[name=?]", "quote[message]"
    end
  end
end
