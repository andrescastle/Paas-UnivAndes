require 'spec_helper'

describe "recursos/index" do
  before(:each) do
    assign(:recursos, [
      stub_model(Recurso,
        :nombre => "Nombre",
        :tipo_recurso => nil,
        :costo => "",
        :unidades => "",
        :descripcion => "Descripcion",
        :organizacion => nil
      ),
      stub_model(Recurso,
        :nombre => "Nombre",
        :tipo_recurso => nil,
        :costo => "",
        :unidades => "",
        :descripcion => "Descripcion",
        :organizacion => nil
      )
    ])
  end

  it "renders a list of recursos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
