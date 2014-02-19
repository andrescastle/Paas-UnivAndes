require "spec_helper"

describe ProyectoOrganizacionsController do
  describe "routing" do

    it "routes to #index" do
      get("/proyecto_organizacions").should route_to("proyecto_organizacions#index")
    end

    it "routes to #new" do
      get("/proyecto_organizacions/new").should route_to("proyecto_organizacions#new")
    end

    it "routes to #show" do
      get("/proyecto_organizacions/1").should route_to("proyecto_organizacions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/proyecto_organizacions/1/edit").should route_to("proyecto_organizacions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/proyecto_organizacions").should route_to("proyecto_organizacions#create")
    end

    it "routes to #update" do
      put("/proyecto_organizacions/1").should route_to("proyecto_organizacions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/proyecto_organizacions/1").should route_to("proyecto_organizacions#destroy", :id => "1")
    end

  end
end
