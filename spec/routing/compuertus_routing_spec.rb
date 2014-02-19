require "spec_helper"

describe CompuertusController do
  describe "routing" do

    it "routes to #index" do
      get("/compuertus").should route_to("compuertus#index")
    end

    it "routes to #new" do
      get("/compuertus/new").should route_to("compuertus#new")
    end

    it "routes to #show" do
      get("/compuertus/1").should route_to("compuertus#show", :id => "1")
    end

    it "routes to #edit" do
      get("/compuertus/1/edit").should route_to("compuertus#edit", :id => "1")
    end

    it "routes to #create" do
      post("/compuertus").should route_to("compuertus#create")
    end

    it "routes to #update" do
      put("/compuertus/1").should route_to("compuertus#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/compuertus/1").should route_to("compuertus#destroy", :id => "1")
    end

  end
end
