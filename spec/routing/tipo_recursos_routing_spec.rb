require "spec_helper"

describe TipoRecursosController do
  describe "routing" do

    it "routes to #index" do
      get("/tipo_recursos").should route_to("tipo_recursos#index")
    end

    it "routes to #new" do
      get("/tipo_recursos/new").should route_to("tipo_recursos#new")
    end

    it "routes to #show" do
      get("/tipo_recursos/1").should route_to("tipo_recursos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tipo_recursos/1/edit").should route_to("tipo_recursos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tipo_recursos").should route_to("tipo_recursos#create")
    end

    it "routes to #update" do
      put("/tipo_recursos/1").should route_to("tipo_recursos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tipo_recursos/1").should route_to("tipo_recursos#destroy", :id => "1")
    end

  end
end
