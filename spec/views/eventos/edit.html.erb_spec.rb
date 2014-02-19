require 'spec_helper'

describe "eventos/edit" do
  before(:each) do
    @evento = assign(:evento, stub_model(Evento,
      :nombre => "MyString",
      :descripcion => "MyString",
      :tipo => 1,
      :plantilla => nil,
      :my_js_tree => nil
    ))
  end

  it "renders the edit evento form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => eventos_path(@evento), :method => "post" do
      assert_select "input#evento_nombre", :name => "evento[nombre]"
      assert_select "input#evento_descripcion", :name => "evento[descripcion]"
      assert_select "input#evento_tipo", :name => "evento[tipo]"
      assert_select "input#evento_plantilla", :name => "evento[plantilla]"
      assert_select "input#evento_my_js_tree", :name => "evento[my_js_tree]"
    end
  end
end
