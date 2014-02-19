require "spec_helper"

describe TareaArtefactosController do
  describe "routing" do

    it "routes to #index" do
      get("/tarea_artefactos").should route_to("tarea_artefactos#index")
    end

    it "routes to #new" do
      get("/tarea_artefactos/new").should route_to("tarea_artefactos#new")
    end

    it "routes to #show" do
      get("/tarea_artefactos/1").should route_to("tarea_artefactos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tarea_artefactos/1/edit").should route_to("tarea_artefactos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tarea_artefactos").should route_to("tarea_artefactos#create")
    end

    it "routes to #update" do
      put("/tarea_artefactos/1").should route_to("tarea_artefactos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tarea_artefactos/1").should route_to("tarea_artefactos#destroy", :id => "1")
    end

  end
end
