require 'rails_helper'

RSpec.describe "services/edit", type: :view do
  let(:service) {
    Service.create!(
      title: "MyString",
      description: "MyText",
      user: nil
    )
  }

  before(:each) do
    assign(:service, service)
  end

  it "renders the edit service form" do
    render

    assert_select "form[action=?][method=?]", service_path(service), "post" do
      assert_select "input[name=?]", "service[title]"

      assert_select "textarea[name=?]", "service[description]"

      assert_select "input[name=?]", "service[user_id]"
    end
  end
end
