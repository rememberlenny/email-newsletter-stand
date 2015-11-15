require "rails_helper"

RSpec.describe AddImageToNewslettersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/add_image_to_newsletters").to route_to("add_image_to_newsletters#index")
    end

    it "routes to #new" do
      expect(:get => "/add_image_to_newsletters/new").to route_to("add_image_to_newsletters#new")
    end

    it "routes to #show" do
      expect(:get => "/add_image_to_newsletters/1").to route_to("add_image_to_newsletters#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/add_image_to_newsletters/1/edit").to route_to("add_image_to_newsletters#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/add_image_to_newsletters").to route_to("add_image_to_newsletters#create")
    end

    it "routes to #update" do
      expect(:put => "/add_image_to_newsletters/1").to route_to("add_image_to_newsletters#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/add_image_to_newsletters/1").to route_to("add_image_to_newsletters#destroy", :id => "1")
    end

  end
end
