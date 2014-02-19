require "spec_helper"

describe TareaRecursosController do
  describe "routing" do

    it "routes to #index" do
      get("/tarea_recursos").should route_to("tarea_recursos#index")
    end

    it "routes to #new" do
      get("/tarea_recursos/new").should route_to("tarea_recursos#new")
    end

    it "routes to #show" do
      get("/tarea_recursos/1").should route_to("tarea_recursos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tarea_recursos/1/edit").should route_to("tarea_recursos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tarea_recursos").should route_to("tarea_recursos#create")
    end

    it "routes to #update" do
      put("/tarea_recursos/1").should route_to("tarea_recursos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tarea_recursos/1").should route_to("tarea_recursos#destroy", :id => "1")
    end

  end
end
