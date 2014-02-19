require 'spec_helper'

describe "procesos/index" do
  before(:each) do
    assign(:procesos, [
      stub_model(Proceso,
        :id => 1,
        :nombre => "Nombre",
        :descripcion => "Descripcion",
        :tipo_plantilla_id => 2,
        :proyecto_id => 3
      ),
      stub_model(Proceso,
        :id => 1,
        :nombre => "Nombre",
        :descripcion => "Descripcion",
        :tipo_plantilla_id => 2,
        :proyecto_id => 3
      )
    ])
  end

  it "renders a list of procesos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
