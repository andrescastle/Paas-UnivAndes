require "spec_helper"

describe ActividadsController do
  describe "routing" do

    it "routes to #index" do
      get("/actividads").should route_to("actividads#index")
    end

    it "routes to #new" do
      get("/actividads/new").should route_to("actividads#new")
    end

    it "routes to #show" do
      get("/actividads/1").should route_to("actividads#show", :id => "1")
    end

    it "routes to #edit" do
      get("/actividads/1/edit").should route_to("actividads#edit", :id => "1")
    end

    it "routes to #create" do
      post("/actividads").should route_to("actividads#create")
    end

    it "routes to #update" do
      put("/actividads/1").should route_to("actividads#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/actividads/1").should route_to("actividads#destroy", :id => "1")
    end

  end
end
