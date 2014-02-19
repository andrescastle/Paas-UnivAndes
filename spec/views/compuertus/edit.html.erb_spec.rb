require 'spec_helper'

describe "compuertus/edit" do
  before(:each) do
    @compuertu = assign(:compuertu, stub_model(Compuertu,
      :nombre => "MyString",
      :descripcion => "MyString",
      :tipo => 1,
      :desicion => 1,
      :plantilla => nil
    ))
  end

  it "renders the edit compuertu form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => compuertus_path(@compuertu), :method => "post" do
      assert_select "input#compuertu_nombre", :name => "compuertu[nombre]"
      assert_select "input#compuertu_descripcion", :name => "compuertu[descripcion]"
      assert_select "input#compuertu_tipo", :name => "compuertu[tipo]"
      assert_select "input#compuertu_desicion", :name => "compuertu[desicion]"
      assert_select "input#compuertu_plantilla", :name => "compuertu[plantilla]"
    end
  end
end
