require "spec_helper"

describe ProyectoUsuariosController do
  describe "routing" do

    it "routes to #index" do
      get("/proyecto_usuarios").should route_to("proyecto_usuarios#index")
    end

    it "routes to #new" do
      get("/proyecto_usuarios/new").should route_to("proyecto_usuarios#new")
    end

    it "routes to #show" do
      get("/proyecto_usuarios/1").should route_to("proyecto_usuarios#show", :id => "1")
    end

    it "routes to #edit" do
      get("/proyecto_usuarios/1/edit").should route_to("proyecto_usuarios#edit", :id => "1")
    end

    it "routes to #create" do
      post("/proyecto_usuarios").should route_to("proyecto_usuarios#create")
    end

    it "routes to #update" do
      put("/proyecto_usuarios/1").should route_to("proyecto_usuarios#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/proyecto_usuarios/1").should route_to("proyecto_usuarios#destroy", :id => "1")
    end

  end
end
