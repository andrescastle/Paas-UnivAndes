require 'spec_helper'

describe "actividad_tipoartefactos/edit" do
  before(:each) do
    @actividad_tipoartefacto = assign(:actividad_tipoartefacto, stub_model(ActividadTipoartefacto,
      :id => 1,
      :actividad_id => 1,
      :tipo_artefacto_id => 1,
      :modo => "MyString"
    ))
  end

  it "renders the edit actividad_tipoartefacto form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => actividad_tipoartefactos_path(@actividad_tipoartefacto), :method => "post" do
      assert_select "input#actividad_tipoartefacto_id", :name => "actividad_tipoartefacto[id]"
      assert_select "input#actividad_tipoartefacto_actividad_id", :name => "actividad_tipoartefacto[actividad_id]"
      assert_select "input#actividad_tipoartefacto_tipo_artefacto_id", :name => "actividad_tipoartefacto[tipo_artefacto_id]"
      assert_select "input#actividad_tipoartefacto_modo", :name => "actividad_tipoartefacto[modo]"
    end
  end
end
