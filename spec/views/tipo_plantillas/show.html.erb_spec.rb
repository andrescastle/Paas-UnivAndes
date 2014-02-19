require 'spec_helper'

describe "tipo_plantillas/show" do
  before(:each) do
    @tipo_plantilla = assign(:tipo_plantilla, stub_model(TipoPlantilla,
      :nombre => "Nombre",
      :descripcion => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    rendered.should match(/MyText/)
  end
end
