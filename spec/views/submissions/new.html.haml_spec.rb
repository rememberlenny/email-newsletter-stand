require 'rails_helper'

RSpec.describe "submissions/new", :type => :view do
  before(:each) do
    assign(:submission, Submission.new(
      :url => "MyString",
      :description => "MyText",
      :name => "MyString"
    ))
  end

  it "renders new submission form" do
    render

    assert_select "form[action=?][method=?]", submissions_path, "post" do

      assert_select "input#submission_url[name=?]", "submission[url]"

      assert_select "textarea#submission_description[name=?]", "submission[description]"

      assert_select "input#submission_name[name=?]", "submission[name]"
    end
  end
end
