require "spec_helper"

describe TareaPresedenciaController do
  describe "routing" do

    it "routes to #index" do
      get("/tarea_presedencia").should route_to("tarea_presedencia#index")
    end

    it "routes to #new" do
      get("/tarea_presedencia/new").should route_to("tarea_presedencia#new")
    end

    it "routes to #show" do
      get("/tarea_presedencia/1").should route_to("tarea_presedencia#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tarea_presedencia/1/edit").should route_to("tarea_presedencia#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tarea_presedencia").should route_to("tarea_presedencia#create")
    end

    it "routes to #update" do
      put("/tarea_presedencia/1").should route_to("tarea_presedencia#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tarea_presedencia/1").should route_to("tarea_presedencia#destroy", :id => "1")
    end

  end
end
