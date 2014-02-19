require 'spec_helper'

describe "recursos/show" do
  before(:each) do
    @recurso = assign(:recurso, stub_model(Recurso,
      :nombre => "Nombre",
      :tipo_recurso => nil,
      :costo => "",
      :unidades => "",
      :descripcion => "Descripcion",
      :organizacion => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Descripcion/)
    rendered.should match(//)
  end
end
