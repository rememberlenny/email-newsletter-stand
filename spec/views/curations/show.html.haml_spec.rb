require 'rails_helper'

RSpec.describe "curations/show", :type => :view do
  before(:each) do
    @curation = assign(:curation, Curation.create!(
      :name => "Name",
      :placement => "Placement"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Placement/)
  end
end
