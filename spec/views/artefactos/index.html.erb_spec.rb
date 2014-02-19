require 'spec_helper'

describe "artefactos/index" do
  before(:each) do
    assign(:artefactos, [
      stub_model(Artefacto,
        :id => 1,
        :nombre => "Nombre",
        :tipo_artefacto_id => 2,
        :imagen => "Imagen",
        :descripcion => "Descripcion"
      ),
      stub_model(Artefacto,
        :id => 1,
        :nombre => "Nombre",
        :tipo_artefacto_id => 2,
        :imagen => "Imagen",
        :descripcion => "Descripcion"
      )
    ])
  end

  it "renders a list of artefactos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Imagen".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
  end
end
