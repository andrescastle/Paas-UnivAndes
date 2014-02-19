require 'spec_helper'

describe "proyecto_usuarios/index" do
  before(:each) do
    assign(:proyecto_usuarios, [
      stub_model(ProyectoUsuario,
        :proyecto_id => 1,
        :usuario_id => ""
      ),
      stub_model(ProyectoUsuario,
        :proyecto_id => 1,
        :usuario_id => ""
      )
    ])
  end

  it "renders a list of proyecto_usuarios" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
