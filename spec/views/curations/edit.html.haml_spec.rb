require 'rails_helper'

RSpec.describe "curations/edit", :type => :view do
  before(:each) do
    @curation = assign(:curation, Curation.create!(
      :name => "MyString",
      :placement => "MyString"
    ))
  end

  it "renders the edit curation form" do
    render

    assert_select "form[action=?][method=?]", curation_path(@curation), "post" do

      assert_select "input#curation_name[name=?]", "curation[name]"

      assert_select "input#curation_placement[name=?]", "curation[placement]"
    end
  end
end
