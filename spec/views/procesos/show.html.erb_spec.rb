require 'spec_helper'

describe "procesos/show" do
  before(:each) do
    @proceso = assign(:proceso, stub_model(Proceso,
      :id => 1,
      :nombre => "Nombre",
      :descripcion => "Descripcion",
      :tipo_plantilla_id => 2,
      :proyecto_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Nombre/)
    rendered.should match(/Descripcion/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
