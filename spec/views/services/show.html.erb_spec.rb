require 'rails_helper'

RSpec.describe "services/show", type: :view do
  let(:service) { create(:service) }

  before(:each) do
    assign(:service, service)
    assign(:quote, Quote.new)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/#{service.title}/)
    expect(rendered).to match(/#{service.user.name}/)
  end
end
