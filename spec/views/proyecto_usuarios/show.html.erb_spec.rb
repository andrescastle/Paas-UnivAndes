require 'spec_helper'

describe "proyecto_usuarios/show" do
  before(:each) do
    @proyecto_usuario = assign(:proyecto_usuario, stub_model(ProyectoUsuario,
      :proyecto_id => 1,
      :usuario_id => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(//)
  end
end
