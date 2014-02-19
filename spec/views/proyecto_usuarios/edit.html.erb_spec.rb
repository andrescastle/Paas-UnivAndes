require 'spec_helper'

describe "proyecto_usuarios/edit" do
  before(:each) do
    @proyecto_usuario = assign(:proyecto_usuario, stub_model(ProyectoUsuario,
      :proyecto_id => 1,
      :usuario_id => ""
    ))
  end

  it "renders the edit proyecto_usuario form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => proyecto_usuarios_path(@proyecto_usuario), :method => "post" do
      assert_select "input#proyecto_usuario_proyecto_id", :name => "proyecto_usuario[proyecto_id]"
      assert_select "input#proyecto_usuario_usuario_id", :name => "proyecto_usuario[usuario_id]"
    end
  end
end
