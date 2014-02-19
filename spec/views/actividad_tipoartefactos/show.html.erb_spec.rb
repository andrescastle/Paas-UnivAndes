require 'spec_helper'

describe "actividad_tipoartefactos/show" do
  before(:each) do
    @actividad_tipoartefacto = assign(:actividad_tipoartefacto, stub_model(ActividadTipoartefacto,
      :id => 1,
      :actividad_id => 2,
      :tipo_artefacto_id => 3,
      :modo => "Modo"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Modo/)
  end
end
