require 'rails_helper'

RSpec.describe "add_image_to_newsletters/index", :type => :view do
  before(:each) do
    assign(:add_image_to_newsletters, [
      AddImageToNewsletter.create!(),
      AddImageToNewsletter.create!()
    ])
  end

  it "renders a list of add_image_to_newsletters" do
    render
  end
end
