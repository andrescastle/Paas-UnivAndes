require 'spec_helper'

describe "plantillas/index" do
  before(:each) do
    assign(:plantillas, [
      stub_model(Plantilla,
        :nombre => "Nombre",
        :tipo_plantilla => nil,
        :descripcion => "MyText",
        :logo => "",
        :filename => "Filename"
      ),
      stub_model(Plantilla,
        :nombre => "Nombre",
        :tipo_plantilla => nil,
        :descripcion => "MyText",
        :logo => "",
        :filename => "Filename"
      )
    ])
  end

  it "renders a list of plantillas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Filename".to_s, :count => 2
  end
end
