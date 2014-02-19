require "spec_helper"

describe MyJsTreesController do
  describe "routing" do

    it "routes to #index" do
      get("/my_js_trees").should route_to("my_js_trees#index")
    end

    it "routes to #new" do
      get("/my_js_trees/new").should route_to("my_js_trees#new")
    end

    it "routes to #show" do
      get("/my_js_trees/1").should route_to("my_js_trees#show", :id => "1")
    end

    it "routes to #edit" do
      get("/my_js_trees/1/edit").should route_to("my_js_trees#edit", :id => "1")
    end

    it "routes to #create" do
      post("/my_js_trees").should route_to("my_js_trees#create")
    end

    it "routes to #update" do
      put("/my_js_trees/1").should route_to("my_js_trees#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/my_js_trees/1").should route_to("my_js_trees#destroy", :id => "1")
    end

  end
end
