require 'spec_helper'

describe "plantillas/show" do
  before(:each) do
    @plantilla = assign(:plantilla, stub_model(Plantilla,
      :nombre => "Nombre",
      :tipo_plantilla => nil,
      :descripcion => "MyText",
      :logo => "",
      :filename => "Filename"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    rendered.should match(//)
    rendered.should match(/MyText/)
    rendered.should match(//)
    rendered.should match(/Filename/)
  end
end
