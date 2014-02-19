require "spec_helper"

describe RecursosController do
  describe "routing" do

    it "routes to #index" do
      get("/recursos").should route_to("recursos#index")
    end

    it "routes to #new" do
      get("/recursos/new").should route_to("recursos#new")
    end

    it "routes to #show" do
      get("/recursos/1").should route_to("recursos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recursos/1/edit").should route_to("recursos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recursos").should route_to("recursos#create")
    end

    it "routes to #update" do
      put("/recursos/1").should route_to("recursos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recursos/1").should route_to("recursos#destroy", :id => "1")
    end

  end
end
