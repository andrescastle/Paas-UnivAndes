require "spec_helper"

describe ProcesosController do
  describe "routing" do

    it "routes to #index" do
      get("/procesos").should route_to("procesos#index")
    end

    it "routes to #new" do
      get("/procesos/new").should route_to("procesos#new")
    end

    it "routes to #show" do
      get("/procesos/1").should route_to("procesos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/procesos/1/edit").should route_to("procesos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/procesos").should route_to("procesos#create")
    end

    it "routes to #update" do
      put("/procesos/1").should route_to("procesos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/procesos/1").should route_to("procesos#destroy", :id => "1")
    end

  end
end
