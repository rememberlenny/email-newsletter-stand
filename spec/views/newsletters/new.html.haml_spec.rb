require 'rails_helper'

RSpec.describe "newsletters/new", :type => :view do
  before(:each) do
    assign(:newsletter, Newsletter.new(
      :name => "MyString",
      :url => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new newsletter form" do
    render

    assert_select "form[action=?][method=?]", newsletters_path, "post" do

      assert_select "input#newsletter_name[name=?]", "newsletter[name]"

      assert_select "input#newsletter_url[name=?]", "newsletter[url]"

      assert_select "textarea#newsletter_description[name=?]", "newsletter[description]"
    end
  end
end
