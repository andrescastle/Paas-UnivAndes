require 'spec_helper'

describe "ProyectoUsuarios" do
  describe "GET /proyecto_usuarios" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get proyecto_usuarios_path
      response.status.should be(200)
    end
  end
end
