require 'spec_helper'

describe "actividad_tiporecursos/index" do
  before(:each) do
    assign(:actividad_tiporecursos, [
      stub_model(ActividadTiporecurso,
        :actividad => nil,
        :tipo_recurso => nil
      ),
      stub_model(ActividadTiporecurso,
        :actividad => nil,
        :tipo_recurso => nil
      )
    ])
  end

  it "renders a list of actividad_tiporecursos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
