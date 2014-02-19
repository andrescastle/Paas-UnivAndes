require 'spec_helper'

describe "transicions/new" do
  before(:each) do
    assign(:transicion, stub_model(Transicion,
      :id => 1,
      :nombre => "MyString",
      :tipo_inicio => "MyString",
      :incio_id => 1,
      :tipo_fin => "MyString",
      :fin_id => 1,
      :proceso_id => 1
    ).as_new_record)
  end

  it "renders new transicion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => transicions_path, :method => "post" do
      assert_select "input#transicion_id", :name => "transicion[id]"
      assert_select "input#transicion_nombre", :name => "transicion[nombre]"
      assert_select "input#transicion_tipo_inicio", :name => "transicion[tipo_inicio]"
      assert_select "input#transicion_incio_id", :name => "transicion[incio_id]"
      assert_select "input#transicion_tipo_fin", :name => "transicion[tipo_fin]"
      assert_select "input#transicion_fin_id", :name => "transicion[fin_id]"
      assert_select "input#transicion_proceso_id", :name => "transicion[proceso_id]"
    end
  end
end
