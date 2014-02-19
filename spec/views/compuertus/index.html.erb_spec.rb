require 'spec_helper'

describe "compuertus/index" do
  before(:each) do
    assign(:compuertus, [
      stub_model(Compuertu,
        :nombre => "Nombre",
        :descripcion => "Descripcion",
        :tipo => 1,
        :desicion => 2,
        :plantilla => nil
      ),
      stub_model(Compuertu,
        :nombre => "Nombre",
        :descripcion => "Descripcion",
        :tipo => 1,
        :desicion => 2,
        :plantilla => nil
      )
    ])
  end

  it "renders a list of compuertus" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
