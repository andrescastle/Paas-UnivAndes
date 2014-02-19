require 'spec_helper'

describe "actividad_rols/show" do
  before(:each) do
    @actividad_rol = assign(:actividad_rol, stub_model(ActividadRol,
      :id => 1,
      :actividad_id => 2,
      :rol_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
