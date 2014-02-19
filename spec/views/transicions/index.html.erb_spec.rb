require 'spec_helper'

describe "transicions/index" do
  before(:each) do
    assign(:transicions, [
      stub_model(Transicion,
        :id => 1,
        :nombre => "Nombre",
        :tipo_inicio => "Tipo Inicio",
        :incio_id => 2,
        :tipo_fin => "Tipo Fin",
        :fin_id => 3,
        :proceso_id => 4
      ),
      stub_model(Transicion,
        :id => 1,
        :nombre => "Nombre",
        :tipo_inicio => "Tipo Inicio",
        :incio_id => 2,
        :tipo_fin => "Tipo Fin",
        :fin_id => 3,
        :proceso_id => 4
      )
    ])
  end

  it "renders a list of transicions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "Tipo Inicio".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Tipo Fin".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
