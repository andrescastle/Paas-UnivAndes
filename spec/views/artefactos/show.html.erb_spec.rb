require 'spec_helper'

describe "artefactos/show" do
  before(:each) do
    @artefacto = assign(:artefacto, stub_model(Artefacto,
      :id => 1,
      :nombre => "Nombre",
      :tipo_artefacto_id => 2,
      :imagen => "Imagen",
      :descripcion => "Descripcion"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Nombre/)
    rendered.should match(/2/)
    rendered.should match(/Imagen/)
    rendered.should match(/Descripcion/)
  end
end
