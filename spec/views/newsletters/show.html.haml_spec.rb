require 'rails_helper'

RSpec.describe "newsletters/show", :type => :view do
  before(:each) do
    @newsletter = assign(:newsletter, Newsletter.create!(
      :name => "Name",
      :url => "Url",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/MyText/)
  end
end
