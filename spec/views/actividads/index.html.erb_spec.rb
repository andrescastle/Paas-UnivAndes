require 'spec_helper'

describe "actividads/index" do
  before(:each) do
    assign(:actividads, [
      stub_model(Actividad,
        :nombre => "Nombre",
        :descripcion => "Descripcion",
        :modoejecucion => 1,
        :plantilla => nil
      ),
      stub_model(Actividad,
        :nombre => "Nombre",
        :descripcion => "Descripcion",
        :modoejecucion => 1,
        :plantilla => nil
      )
    ])
  end

  it "renders a list of actividads" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
