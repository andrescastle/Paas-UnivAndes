require 'spec_helper'

describe "ruta/new" do
  before(:each) do
    assign(:rutum, stub_model(Rutum,
      :nombre => "MyString",
      :descripcion => "MyString",
      :tipo => 1,
      :plantilla => nil,
      :my_js_tree => nil
    ).as_new_record)
  end

  it "renders new rutum form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ruta_path, :method => "post" do
      assert_select "input#rutum_nombre", :name => "rutum[nombre]"
      assert_select "input#rutum_descripcion", :name => "rutum[descripcion]"
      assert_select "input#rutum_tipo", :name => "rutum[tipo]"
      assert_select "input#rutum_plantilla", :name => "rutum[plantilla]"
      assert_select "input#rutum_my_js_tree", :name => "rutum[my_js_tree]"
    end
  end
end
