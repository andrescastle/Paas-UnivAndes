require "spec_helper"

describe ActividadTipoartefactosController do
  describe "routing" do

    it "routes to #index" do
      get("/actividad_tipoartefactos").should route_to("actividad_tipoartefactos#index")
    end

    it "routes to #new" do
      get("/actividad_tipoartefactos/new").should route_to("actividad_tipoartefactos#new")
    end

    it "routes to #show" do
      get("/actividad_tipoartefactos/1").should route_to("actividad_tipoartefactos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/actividad_tipoartefactos/1/edit").should route_to("actividad_tipoartefactos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/actividad_tipoartefactos").should route_to("actividad_tipoartefactos#create")
    end

    it "routes to #update" do
      put("/actividad_tipoartefactos/1").should route_to("actividad_tipoartefactos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/actividad_tipoartefactos/1").should route_to("actividad_tipoartefactos#destroy", :id => "1")
    end

  end
end
