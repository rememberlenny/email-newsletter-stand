require "rails_helper"

RSpec.describe CurationsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/curations").to route_to("curations#index")
    end

    it "routes to #new" do
      expect(:get => "/curations/new").to route_to("curations#new")
    end

    it "routes to #show" do
      expect(:get => "/curations/1").to route_to("curations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/curations/1/edit").to route_to("curations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/curations").to route_to("curations#create")
    end

    it "routes to #update" do
      expect(:put => "/curations/1").to route_to("curations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/curations/1").to route_to("curations#destroy", :id => "1")
    end

  end
end
