require 'spec_helper'

describe "tipo_organizacions/edit" do
  before(:each) do
    @tipo_organizacion = assign(:tipo_organizacion, stub_model(TipoOrganizacion,
      :name => "MyString"
    ))
  end

  it "renders the edit tipo_organizacion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tipo_organizacions_path(@tipo_organizacion), :method => "post" do
      assert_select "input#tipo_organizacion_name", :name => "tipo_organizacion[name]"
    end
  end
end
