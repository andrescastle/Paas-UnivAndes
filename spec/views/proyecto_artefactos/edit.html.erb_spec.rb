require 'spec_helper'

describe "proyecto_artefactos/edit" do
  before(:each) do
    @proyecto_artefacto = assign(:proyecto_artefacto, stub_model(ProyectoArtefacto,
      :proyecto_id => 1,
      :artefacto_id => 1
    ))
  end

  it "renders the edit proyecto_artefacto form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => proyecto_artefactos_path(@proyecto_artefacto), :method => "post" do
      assert_select "input#proyecto_artefacto_proyecto_id", :name => "proyecto_artefacto[proyecto_id]"
      assert_select "input#proyecto_artefacto_artefacto_id", :name => "proyecto_artefacto[artefacto_id]"
    end
  end
end
