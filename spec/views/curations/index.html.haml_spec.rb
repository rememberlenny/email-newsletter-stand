require 'rails_helper'

RSpec.describe "curations/index", :type => :view do
  before(:each) do
    assign(:curations, [
      Curation.create!(
        :name => "Name",
        :placement => "Placement"
      ),
      Curation.create!(
        :name => "Name",
        :placement => "Placement"
      )
    ])
  end

  it "renders a list of curations" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Placement".to_s, :count => 2
  end
end
