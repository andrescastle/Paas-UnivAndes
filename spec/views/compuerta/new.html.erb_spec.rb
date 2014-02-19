require 'spec_helper'

describe "compuerta/new" do
  before(:each) do
    assign(:compuertum, stub_model(Compuertum,
      :nombre => "MyString",
      :descripcion => "MyString",
      :tipo => 1,
      :desicion => 1,
      :plantilla => nil
    ).as_new_record)
  end

  it "renders new compuertum form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => compuerta_path, :method => "post" do
      assert_select "input#compuertum_nombre", :name => "compuertum[nombre]"
      assert_select "input#compuertum_descripcion", :name => "compuertum[descripcion]"
      assert_select "input#compuertum_tipo", :name => "compuertum[tipo]"
      assert_select "input#compuertum_desicion", :name => "compuertum[desicion]"
      assert_select "input#compuertum_plantilla", :name => "compuertum[plantilla]"
    end
  end
end
