require "spec_helper"

describe TareaParticipantesController do
  describe "routing" do

    it "routes to #index" do
      get("/tarea_participantes").should route_to("tarea_participantes#index")
    end

    it "routes to #new" do
      get("/tarea_participantes/new").should route_to("tarea_participantes#new")
    end

    it "routes to #show" do
      get("/tarea_participantes/1").should route_to("tarea_participantes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tarea_participantes/1/edit").should route_to("tarea_participantes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tarea_participantes").should route_to("tarea_participantes#create")
    end

    it "routes to #update" do
      put("/tarea_participantes/1").should route_to("tarea_participantes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tarea_participantes/1").should route_to("tarea_participantes#destroy", :id => "1")
    end

  end
end
