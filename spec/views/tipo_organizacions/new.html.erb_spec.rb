require 'spec_helper'

describe "tipo_organizacions/new" do
  before(:each) do
    assign(:tipo_organizacion, stub_model(TipoOrganizacion,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new tipo_organizacion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tipo_organizacions_path, :method => "post" do
      assert_select "input#tipo_organizacion_name", :name => "tipo_organizacion[name]"
    end
  end
end
