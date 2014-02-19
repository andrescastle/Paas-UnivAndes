require "spec_helper"

describe TareaRevisionsController do
  describe "routing" do

    it "routes to #index" do
      get("/tarea_revisions").should route_to("tarea_revisions#index")
    end

    it "routes to #new" do
      get("/tarea_revisions/new").should route_to("tarea_revisions#new")
    end

    it "routes to #show" do
      get("/tarea_revisions/1").should route_to("tarea_revisions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tarea_revisions/1/edit").should route_to("tarea_revisions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tarea_revisions").should route_to("tarea_revisions#create")
    end

    it "routes to #update" do
      put("/tarea_revisions/1").should route_to("tarea_revisions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tarea_revisions/1").should route_to("tarea_revisions#destroy", :id => "1")
    end

  end
end
