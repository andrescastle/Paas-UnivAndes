require "spec_helper"

describe TipoPlantillasController do
  describe "routing" do

    it "routes to #index" do
      get("/tipo_plantillas").should route_to("tipo_plantillas#index")
    end

    it "routes to #new" do
      get("/tipo_plantillas/new").should route_to("tipo_plantillas#new")
    end

    it "routes to #show" do
      get("/tipo_plantillas/1").should route_to("tipo_plantillas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tipo_plantillas/1/edit").should route_to("tipo_plantillas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tipo_plantillas").should route_to("tipo_plantillas#create")
    end

    it "routes to #update" do
      put("/tipo_plantillas/1").should route_to("tipo_plantillas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tipo_plantillas/1").should route_to("tipo_plantillas#destroy", :id => "1")
    end

  end
end
