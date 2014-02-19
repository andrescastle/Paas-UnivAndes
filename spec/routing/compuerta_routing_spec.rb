require "spec_helper"

describe CompuertaController do
  describe "routing" do

    it "routes to #index" do
      get("/compuerta").should route_to("compuerta#index")
    end

    it "routes to #new" do
      get("/compuerta/new").should route_to("compuerta#new")
    end

    it "routes to #show" do
      get("/compuerta/1").should route_to("compuerta#show", :id => "1")
    end

    it "routes to #edit" do
      get("/compuerta/1/edit").should route_to("compuerta#edit", :id => "1")
    end

    it "routes to #create" do
      post("/compuerta").should route_to("compuerta#create")
    end

    it "routes to #update" do
      put("/compuerta/1").should route_to("compuerta#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/compuerta/1").should route_to("compuerta#destroy", :id => "1")
    end

  end
end
