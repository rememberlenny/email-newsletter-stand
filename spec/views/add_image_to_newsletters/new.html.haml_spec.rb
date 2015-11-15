require 'rails_helper'

RSpec.describe "add_image_to_newsletters/new", :type => :view do
  before(:each) do
    assign(:add_image_to_newsletter, AddImageToNewsletter.new())
  end

  it "renders new add_image_to_newsletter form" do
    render

    assert_select "form[action=?][method=?]", add_image_to_newsletters_path, "post" do
    end
  end
end
