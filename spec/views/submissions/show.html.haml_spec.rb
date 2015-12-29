require 'rails_helper'

RSpec.describe "submissions/show", :type => :view do
  before(:each) do
    @submission = assign(:submission, Submission.create!(
      :url => "Url",
      :description => "MyText",
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Name/)
  end
end
