require 'spec_helper'

describe "artefactos/edit" do
  before(:each) do
    @artefacto = assign(:artefacto, stub_model(Artefacto,
      :id => 1,
      :nombre => "MyString",
      :tipo_artefacto_id => 1,
      :imagen => "MyString",
      :descripcion => "MyString"
    ))
  end

  it "renders the edit artefacto form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => artefactos_path(@artefacto), :method => "post" do
      assert_select "input#artefacto_id", :name => "artefacto[id]"
      assert_select "input#artefacto_nombre", :name => "artefacto[nombre]"
      assert_select "input#artefacto_tipo_artefacto_id", :name => "artefacto[tipo_artefacto_id]"
      assert_select "input#artefacto_imagen", :name => "artefacto[imagen]"
      assert_select "input#artefacto_descripcion", :name => "artefacto[descripcion]"
    end
  end
end
