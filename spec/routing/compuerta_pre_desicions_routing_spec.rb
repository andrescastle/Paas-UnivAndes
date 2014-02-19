require "spec_helper"

describe CompuertaPreDesicionsController do
  describe "routing" do

    it "routes to #index" do
      get("/compuerta_pre_desicions").should route_to("compuerta_pre_desicions#index")
    end

    it "routes to #new" do
      get("/compuerta_pre_desicions/new").should route_to("compuerta_pre_desicions#new")
    end

    it "routes to #show" do
      get("/compuerta_pre_desicions/1").should route_to("compuerta_pre_desicions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/compuerta_pre_desicions/1/edit").should route_to("compuerta_pre_desicions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/compuerta_pre_desicions").should route_to("compuerta_pre_desicions#create")
    end

    it "routes to #update" do
      put("/compuerta_pre_desicions/1").should route_to("compuerta_pre_desicions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/compuerta_pre_desicions/1").should route_to("compuerta_pre_desicions#destroy", :id => "1")
    end

  end
end
