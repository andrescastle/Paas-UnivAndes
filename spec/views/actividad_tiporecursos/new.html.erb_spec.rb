require 'spec_helper'

describe "actividad_tiporecursos/new" do
  before(:each) do
    assign(:actividad_tiporecurso, stub_model(ActividadTiporecurso,
      :actividad => nil,
      :tipo_recurso => nil
    ).as_new_record)
  end

  it "renders new actividad_tiporecurso form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => actividad_tiporecursos_path, :method => "post" do
      assert_select "input#actividad_tiporecurso_actividad", :name => "actividad_tiporecurso[actividad]"
      assert_select "input#actividad_tiporecurso_tipo_recurso", :name => "actividad_tiporecurso[tipo_recurso]"
    end
  end
end
