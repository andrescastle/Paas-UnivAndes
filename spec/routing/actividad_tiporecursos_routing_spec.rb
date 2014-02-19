require "spec_helper"

describe ActividadTiporecursosController do
  describe "routing" do

    it "routes to #index" do
      get("/actividad_tiporecursos").should route_to("actividad_tiporecursos#index")
    end

    it "routes to #new" do
      get("/actividad_tiporecursos/new").should route_to("actividad_tiporecursos#new")
    end

    it "routes to #show" do
      get("/actividad_tiporecursos/1").should route_to("actividad_tiporecursos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/actividad_tiporecursos/1/edit").should route_to("actividad_tiporecursos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/actividad_tiporecursos").should route_to("actividad_tiporecursos#create")
    end

    it "routes to #update" do
      put("/actividad_tiporecursos/1").should route_to("actividad_tiporecursos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/actividad_tiporecursos/1").should route_to("actividad_tiporecursos#destroy", :id => "1")
    end

  end
end
