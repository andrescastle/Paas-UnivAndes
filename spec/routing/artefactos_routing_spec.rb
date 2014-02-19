require "spec_helper"

describe ArtefactosController do
  describe "routing" do

    it "routes to #index" do
      get("/artefactos").should route_to("artefactos#index")
    end

    it "routes to #new" do
      get("/artefactos/new").should route_to("artefactos#new")
    end

    it "routes to #show" do
      get("/artefactos/1").should route_to("artefactos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/artefactos/1/edit").should route_to("artefactos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/artefactos").should route_to("artefactos#create")
    end

    it "routes to #update" do
      put("/artefactos/1").should route_to("artefactos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/artefactos/1").should route_to("artefactos#destroy", :id => "1")
    end

  end
end
