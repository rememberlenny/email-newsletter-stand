require 'rails_helper'

RSpec.describe "newsletters/index", :type => :view do
  before(:each) do
    assign(:newsletters, [
      Newsletter.create!(
        :name => "Name",
        :url => "Url",
        :description => "MyText"
      ),
      Newsletter.create!(
        :name => "Name",
        :url => "Url",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of newsletters" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
