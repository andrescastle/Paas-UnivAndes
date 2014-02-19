require 'spec_helper'

describe "eventos/index" do
  before(:each) do
    assign(:eventos, [
      stub_model(Evento,
        :nombre => "Nombre",
        :descripcion => "Descripcion",
        :tipo => 1,
        :plantilla => nil,
        :my_js_tree => nil
      ),
      stub_model(Evento,
        :nombre => "Nombre",
        :descripcion => "Descripcion",
        :tipo => 1,
        :plantilla => nil,
        :my_js_tree => nil
      )
    ])
  end

  it "renders a list of eventos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
