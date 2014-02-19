require 'spec_helper'

describe "proyecto_organizacions/edit" do
  before(:each) do
    @proyecto_organizacion = assign(:proyecto_organizacion, stub_model(ProyectoOrganizacion,
      :proyecto_id => 1,
      :organizacion_id => 1
    ))
  end

  it "renders the edit proyecto_organizacion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => proyecto_organizacions_path(@proyecto_organizacion), :method => "post" do
      assert_select "input#proyecto_organizacion_proyecto_id", :name => "proyecto_organizacion[proyecto_id]"
      assert_select "input#proyecto_organizacion_organizacion_id", :name => "proyecto_organizacion[organizacion_id]"
    end
  end
end
