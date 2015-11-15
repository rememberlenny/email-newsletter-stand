require 'rails_helper'

RSpec.describe "AddImageToNewsletters", :type => :request do
  describe "GET /add_image_to_newsletters" do
    it "works! (now write some real specs)" do
      get add_image_to_newsletters_path
      expect(response).to have_http_status(200)
    end
  end
end
