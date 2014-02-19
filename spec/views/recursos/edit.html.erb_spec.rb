require 'spec_helper'

describe "recursos/edit" do
  before(:each) do
    @recurso = assign(:recurso, stub_model(Recurso,
      :nombre => "MyString",
      :tipo_recurso => nil,
      :costo => "",
      :unidades => "",
      :descripcion => "MyString",
      :organizacion => nil
    ))
  end

  it "renders the edit recurso form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recursos_path(@recurso), :method => "post" do
      assert_select "input#recurso_nombre", :name => "recurso[nombre]"
      assert_select "input#recurso_tipo_recurso", :name => "recurso[tipo_recurso]"
      assert_select "input#recurso_costo", :name => "recurso[costo]"
      assert_select "input#recurso_unidades", :name => "recurso[unidades]"
      assert_select "input#recurso_descripcion", :name => "recurso[descripcion]"
      assert_select "input#recurso_organizacion", :name => "recurso[organizacion]"
    end
  end
end
