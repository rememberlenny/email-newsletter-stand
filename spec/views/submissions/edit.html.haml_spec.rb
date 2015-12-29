require 'rails_helper'

RSpec.describe "submissions/edit", :type => :view do
  before(:each) do
    @submission = assign(:submission, Submission.create!(
      :url => "MyString",
      :description => "MyText",
      :name => "MyString"
    ))
  end

  it "renders the edit submission form" do
    render

    assert_select "form[action=?][method=?]", submission_path(@submission), "post" do

      assert_select "input#submission_url[name=?]", "submission[url]"

      assert_select "textarea#submission_description[name=?]", "submission[description]"

      assert_select "input#submission_name[name=?]", "submission[name]"
    end
  end
end
