require 'rails_helper'

RSpec.describe "add_image_to_newsletters/edit", :type => :view do
  before(:each) do
    @add_image_to_newsletter = assign(:add_image_to_newsletter, AddImageToNewsletter.create!())
  end

  it "renders the edit add_image_to_newsletter form" do
    render

    assert_select "form[action=?][method=?]", add_image_to_newsletter_path(@add_image_to_newsletter), "post" do
    end
  end
end
