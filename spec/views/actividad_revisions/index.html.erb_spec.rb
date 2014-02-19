require 'spec_helper'

describe "actividad_revisions/index" do
  before(:each) do
    assign(:actividad_revisions, [
      stub_model(ActividadRevision,
        :id => 1,
        :nombre => "Nombre",
        :actividad_id => 2,
        :tipo_recurso_id => 3
      ),
      stub_model(ActividadRevision,
        :id => 1,
        :nombre => "Nombre",
        :actividad_id => 2,
        :tipo_recurso_id => 3
      )
    ])
  end

  it "renders a list of actividad_revisions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
