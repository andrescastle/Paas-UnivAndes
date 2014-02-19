require 'spec_helper'

describe "compuerta/index" do
  before(:each) do
    assign(:compuerta, [
      stub_model(Compuertum,
        :nombre => "Nombre",
        :descripcion => "Descripcion",
        :tipo => 1,
        :desicion => 2,
        :plantilla => nil
      ),
      stub_model(Compuertum,
        :nombre => "Nombre",
        :descripcion => "Descripcion",
        :tipo => 1,
        :desicion => 2,
        :plantilla => nil
      )
    ])
  end

  it "renders a list of compuerta" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
