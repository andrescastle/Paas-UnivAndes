require 'spec_helper'

describe "ActividadTipoartefactos" do
  describe "GET /actividad_tipoartefactos" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get actividad_tipoartefactos_path
      response.status.should be(200)
    end
  end
end
