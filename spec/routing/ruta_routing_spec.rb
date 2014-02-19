require "spec_helper"

describe RutaController do
  describe "routing" do

    it "routes to #index" do
      get("/ruta").should route_to("ruta#index")
    end

    it "routes to #new" do
      get("/ruta/new").should route_to("ruta#new")
    end

    it "routes to #show" do
      get("/ruta/1").should route_to("ruta#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ruta/1/edit").should route_to("ruta#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ruta").should route_to("ruta#create")
    end

    it "routes to #update" do
      put("/ruta/1").should route_to("ruta#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ruta/1").should route_to("ruta#destroy", :id => "1")
    end

  end
end
