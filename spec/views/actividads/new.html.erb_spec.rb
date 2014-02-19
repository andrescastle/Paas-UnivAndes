require 'spec_helper'

describe "actividads/new" do
  before(:each) do
    assign(:actividad, stub_model(Actividad,
      :nombre => "MyString",
      :descripcion => "MyString",
      :modoejecucion => 1,
      :plantilla => nil
    ).as_new_record)
  end

  it "renders new actividad form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => actividads_path, :method => "post" do
      assert_select "input#actividad_nombre", :name => "actividad[nombre]"
      assert_select "input#actividad_descripcion", :name => "actividad[descripcion]"
      assert_select "input#actividad_modoejecucion", :name => "actividad[modoejecucion]"
      assert_select "input#actividad_plantilla", :name => "actividad[plantilla]"
    end
  end
end
