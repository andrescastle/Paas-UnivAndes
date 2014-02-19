require "spec_helper"

describe ProyectoArtefactosController do
  describe "routing" do

    it "routes to #index" do
      get("/proyecto_artefactos").should route_to("proyecto_artefactos#index")
    end

    it "routes to #new" do
      get("/proyecto_artefactos/new").should route_to("proyecto_artefactos#new")
    end

    it "routes to #show" do
      get("/proyecto_artefactos/1").should route_to("proyecto_artefactos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/proyecto_artefactos/1/edit").should route_to("proyecto_artefactos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/proyecto_artefactos").should route_to("proyecto_artefactos#create")
    end

    it "routes to #update" do
      put("/proyecto_artefactos/1").should route_to("proyecto_artefactos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/proyecto_artefactos/1").should route_to("proyecto_artefactos#destroy", :id => "1")
    end

  end
end
