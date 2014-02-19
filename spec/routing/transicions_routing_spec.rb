require "spec_helper"

describe TransicionsController do
  describe "routing" do

    it "routes to #index" do
      get("/transicions").should route_to("transicions#index")
    end

    it "routes to #new" do
      get("/transicions/new").should route_to("transicions#new")
    end

    it "routes to #show" do
      get("/transicions/1").should route_to("transicions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/transicions/1/edit").should route_to("transicions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/transicions").should route_to("transicions#create")
    end

    it "routes to #update" do
      put("/transicions/1").should route_to("transicions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/transicions/1").should route_to("transicions#destroy", :id => "1")
    end

  end
end
