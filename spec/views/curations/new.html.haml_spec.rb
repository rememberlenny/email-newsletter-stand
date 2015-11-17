require 'rails_helper'

RSpec.describe "curations/new", :type => :view do
  before(:each) do
    assign(:curation, Curation.new(
      :name => "MyString",
      :placement => "MyString"
    ))
  end

  it "renders new curation form" do
    render

    assert_select "form[action=?][method=?]", curations_path, "post" do

      assert_select "input#curation_name[name=?]", "curation[name]"

      assert_select "input#curation_placement[name=?]", "curation[placement]"
    end
  end
end
