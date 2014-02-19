require "spec_helper"

describe ActividadRolsController do
  describe "routing" do

    it "routes to #index" do
      get("/actividad_rols").should route_to("actividad_rols#index")
    end

    it "routes to #new" do
      get("/actividad_rols/new").should route_to("actividad_rols#new")
    end

    it "routes to #show" do
      get("/actividad_rols/1").should route_to("actividad_rols#show", :id => "1")
    end

    it "routes to #edit" do
      get("/actividad_rols/1/edit").should route_to("actividad_rols#edit", :id => "1")
    end

    it "routes to #create" do
      post("/actividad_rols").should route_to("actividad_rols#create")
    end

    it "routes to #update" do
      put("/actividad_rols/1").should route_to("actividad_rols#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/actividad_rols/1").should route_to("actividad_rols#destroy", :id => "1")
    end

  end
end
