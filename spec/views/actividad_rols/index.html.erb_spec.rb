require 'spec_helper'

describe "actividad_rols/index" do
  before(:each) do
    assign(:actividad_rols, [
      stub_model(ActividadRol,
        :id => 1,
        :actividad_id => 2,
        :rol_id => 3
      ),
      stub_model(ActividadRol,
        :id => 1,
        :actividad_id => 2,
        :rol_id => 3
      )
    ])
  end

  it "renders a list of actividad_rols" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
