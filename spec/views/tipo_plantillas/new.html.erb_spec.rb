require 'spec_helper'

describe "tipo_plantillas/new" do
  before(:each) do
    assign(:tipo_plantilla, stub_model(TipoPlantilla,
      :nombre => "MyString",
      :descripcion => "MyText"
    ).as_new_record)
  end

  it "renders new tipo_plantilla form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tipo_plantillas_path, :method => "post" do
      assert_select "input#tipo_plantilla_nombre", :name => "tipo_plantilla[nombre]"
      assert_select "textarea#tipo_plantilla_descripcion", :name => "tipo_plantilla[descripcion]"
    end
  end
end
