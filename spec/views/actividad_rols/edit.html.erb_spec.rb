require 'spec_helper'

describe "actividad_rols/edit" do
  before(:each) do
    @actividad_rol = assign(:actividad_rol, stub_model(ActividadRol,
      :id => 1,
      :actividad_id => 1,
      :rol_id => 1
    ))
  end

  it "renders the edit actividad_rol form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => actividad_rols_path(@actividad_rol), :method => "post" do
      assert_select "input#actividad_rol_id", :name => "actividad_rol[id]"
      assert_select "input#actividad_rol_actividad_id", :name => "actividad_rol[actividad_id]"
      assert_select "input#actividad_rol_rol_id", :name => "actividad_rol[rol_id]"
    end
  end
end
