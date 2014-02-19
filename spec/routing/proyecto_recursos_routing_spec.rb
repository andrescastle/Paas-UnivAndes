require "spec_helper"

describe ProyectoRecursosController do
  describe "routing" do

    it "routes to #index" do
      get("/proyecto_recursos").should route_to("proyecto_recursos#index")
    end

    it "routes to #new" do
      get("/proyecto_recursos/new").should route_to("proyecto_recursos#new")
    end

    it "routes to #show" do
      get("/proyecto_recursos/1").should route_to("proyecto_recursos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/proyecto_recursos/1/edit").should route_to("proyecto_recursos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/proyecto_recursos").should route_to("proyecto_recursos#create")
    end

    it "routes to #update" do
      put("/proyecto_recursos/1").should route_to("proyecto_recursos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/proyecto_recursos/1").should route_to("proyecto_recursos#destroy", :id => "1")
    end

  end
end
