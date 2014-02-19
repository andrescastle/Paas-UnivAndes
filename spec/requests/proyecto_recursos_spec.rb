require 'spec_helper'

describe "ProyectoRecursos" do
  describe "GET /proyecto_recursos" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get proyecto_recursos_path
      response.status.should be(200)
    end
  end
end
