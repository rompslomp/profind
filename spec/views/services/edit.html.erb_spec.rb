require 'rails_helper'

RSpec.describe "services/edit", type: :view do
  let(:service) { create(:service) }

  before(:each) do
    assign(:service, service)
    assign(:tags, [])
  end

  it "renders the edit service form" do
    render

    assert_select "form[action=?][method=?]", service_path(service), "post" do
      assert_select "input[name=?]", "service[title]"
      assert_select "textarea[name=?]", "service[description]"
    end
  end
end
