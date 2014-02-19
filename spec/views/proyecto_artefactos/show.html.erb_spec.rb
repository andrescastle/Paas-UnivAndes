require 'spec_helper'

describe "proyecto_artefactos/show" do
  before(:each) do
    @proyecto_artefacto = assign(:proyecto_artefacto, stub_model(ProyectoArtefacto,
      :proyecto_id => 1,
      :artefacto_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
