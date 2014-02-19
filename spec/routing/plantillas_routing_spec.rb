require "spec_helper"

describe PlantillasController do
  describe "routing" do

    it "routes to #index" do
      get("/plantillas").should route_to("plantillas#index")
    end

    it "routes to #new" do
      get("/plantillas/new").should route_to("plantillas#new")
    end

    it "routes to #show" do
      get("/plantillas/1").should route_to("plantillas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/plantillas/1/edit").should route_to("plantillas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/plantillas").should route_to("plantillas#create")
    end

    it "routes to #update" do
      put("/plantillas/1").should route_to("plantillas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/plantillas/1").should route_to("plantillas#destroy", :id => "1")
    end

  end
end
