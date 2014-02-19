require 'spec_helper'

describe "TareaArtefactos" do
  describe "GET /tarea_artefactos" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get tarea_artefactos_path
      response.status.should be(200)
    end
  end
end
