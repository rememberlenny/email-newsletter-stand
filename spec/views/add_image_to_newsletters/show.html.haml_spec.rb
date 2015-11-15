require 'rails_helper'

RSpec.describe "add_image_to_newsletters/show", :type => :view do
  before(:each) do
    @add_image_to_newsletter = assign(:add_image_to_newsletter, AddImageToNewsletter.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
