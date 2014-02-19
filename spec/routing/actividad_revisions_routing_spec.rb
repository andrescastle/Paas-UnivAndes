require "spec_helper"

describe ActividadRevisionsController do
  describe "routing" do

    it "routes to #index" do
      get("/actividad_revisions").should route_to("actividad_revisions#index")
    end

    it "routes to #new" do
      get("/actividad_revisions/new").should route_to("actividad_revisions#new")
    end

    it "routes to #show" do
      get("/actividad_revisions/1").should route_to("actividad_revisions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/actividad_revisions/1/edit").should route_to("actividad_revisions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/actividad_revisions").should route_to("actividad_revisions#create")
    end

    it "routes to #update" do
      put("/actividad_revisions/1").should route_to("actividad_revisions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/actividad_revisions/1").should route_to("actividad_revisions#destroy", :id => "1")
    end

  end
end
