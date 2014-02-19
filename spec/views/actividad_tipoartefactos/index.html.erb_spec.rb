require 'spec_helper'

describe "actividad_tipoartefactos/index" do
  before(:each) do
    assign(:actividad_tipoartefactos, [
      stub_model(ActividadTipoartefacto,
        :id => 1,
        :actividad_id => 2,
        :tipo_artefacto_id => 3,
        :modo => "Modo"
      ),
      stub_model(ActividadTipoartefacto,
        :id => 1,
        :actividad_id => 2,
        :tipo_artefacto_id => 3,
        :modo => "Modo"
      )
    ])
  end

  it "renders a list of actividad_tipoartefactos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Modo".to_s, :count => 2
  end
end
