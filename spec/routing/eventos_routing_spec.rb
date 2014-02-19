require "spec_helper"

describe EventosController do
  describe "routing" do

    it "routes to #index" do
      get("/eventos").should route_to("eventos#index")
    end

    it "routes to #new" do
      get("/eventos/new").should route_to("eventos#new")
    end

    it "routes to #show" do
      get("/eventos/1").should route_to("eventos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/eventos/1/edit").should route_to("eventos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/eventos").should route_to("eventos#create")
    end

    it "routes to #update" do
      put("/eventos/1").should route_to("eventos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/eventos/1").should route_to("eventos#destroy", :id => "1")
    end

  end
end
