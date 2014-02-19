require 'spec_helper'

describe "plantillas/new" do
  before(:each) do
    assign(:plantilla, stub_model(Plantilla,
      :nombre => "MyString",
      :tipo_plantilla => nil,
      :descripcion => "MyText",
      :logo => "",
      :filename => "MyString"
    ).as_new_record)
  end

  it "renders new plantilla form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => plantillas_path, :method => "post" do
      assert_select "input#plantilla_nombre", :name => "plantilla[nombre]"
      assert_select "input#plantilla_tipo_plantilla", :name => "plantilla[tipo_plantilla]"
      assert_select "textarea#plantilla_descripcion", :name => "plantilla[descripcion]"
      assert_select "input#plantilla_logo", :name => "plantilla[logo]"
      assert_select "input#plantilla_filename", :name => "plantilla[filename]"
    end
  end
end
