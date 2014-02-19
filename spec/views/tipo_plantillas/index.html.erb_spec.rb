require 'spec_helper'

describe "tipo_plantillas/index" do
  before(:each) do
    assign(:tipo_plantillas, [
      stub_model(TipoPlantilla,
        :nombre => "Nombre",
        :descripcion => "MyText"
      ),
      stub_model(TipoPlantilla,
        :nombre => "Nombre",
        :descripcion => "MyText"
      )
    ])
  end

  it "renders a list of tipo_plantillas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
