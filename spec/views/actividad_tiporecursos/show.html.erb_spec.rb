require 'spec_helper'

describe "actividad_tiporecursos/show" do
  before(:each) do
    @actividad_tiporecurso = assign(:actividad_tiporecurso, stub_model(ActividadTiporecurso,
      :actividad => nil,
      :tipo_recurso => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
  end
end
