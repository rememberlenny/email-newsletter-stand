require 'rails_helper'

RSpec.describe "submissions/index", :type => :view do
  before(:each) do
    assign(:submissions, [
      Submission.create!(
        :url => "Url",
        :description => "MyText",
        :name => "Name"
      ),
      Submission.create!(
        :url => "Url",
        :description => "MyText",
        :name => "Name"
      )
    ])
  end

  it "renders a list of submissions" do
    render
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
