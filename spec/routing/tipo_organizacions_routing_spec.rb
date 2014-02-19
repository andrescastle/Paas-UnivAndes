require "spec_helper"

describe TipoOrganizacionsController do
  describe "routing" do

    it "routes to #index" do
      get("/tipo_organizacions").should route_to("tipo_organizacions#index")
    end

    it "routes to #new" do
      get("/tipo_organizacions/new").should route_to("tipo_organizacions#new")
    end

    it "routes to #show" do
      get("/tipo_organizacions/1").should route_to("tipo_organizacions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tipo_organizacions/1/edit").should route_to("tipo_organizacions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tipo_organizacions").should route_to("tipo_organizacions#create")
    end

    it "routes to #update" do
      put("/tipo_organizacions/1").should route_to("tipo_organizacions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tipo_organizacions/1").should route_to("tipo_organizacions#destroy", :id => "1")
    end

  end
end
