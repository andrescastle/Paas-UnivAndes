require 'spec_helper'

describe "proyecto_organizacions/show" do
  before(:each) do
    @proyecto_organizacion = assign(:proyecto_organizacion, stub_model(ProyectoOrganizacion,
      :proyecto_id => 1,
      :organizacion_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
