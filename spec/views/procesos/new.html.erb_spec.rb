require 'spec_helper'

describe "procesos/new" do
  before(:each) do
    assign(:proceso, stub_model(Proceso,
      :id => 1,
      :nombre => "MyString",
      :descripcion => "MyString",
      :tipo_plantilla_id => 1,
      :proyecto_id => 1
    ).as_new_record)
  end

  it "renders new proceso form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => procesos_path, :method => "post" do
      assert_select "input#proceso_id", :name => "proceso[id]"
      assert_select "input#proceso_nombre", :name => "proceso[nombre]"
      assert_select "input#proceso_descripcion", :name => "proceso[descripcion]"
      assert_select "input#proceso_tipo_plantilla_id", :name => "proceso[tipo_plantilla_id]"
      assert_select "input#proceso_proyecto_id", :name => "proceso[proyecto_id]"
    end
  end
end
