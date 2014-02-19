require 'spec_helper'

describe "ruta/show" do
  before(:each) do
    @rutum = assign(:rutum, stub_model(Rutum,
      :nombre => "Nombre",
      :descripcion => "Descripcion",
      :tipo => 1,
      :plantilla => nil,
      :my_js_tree => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    rendered.should match(/Descripcion/)
    rendered.should match(/1/)
    rendered.should match(//)
    rendered.should match(//)
  end
end
