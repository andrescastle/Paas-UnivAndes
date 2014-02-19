require 'spec_helper'

describe "compuerta_desicions/index" do
  before(:each) do
    assign(:compuerta_desicions, [
      stub_model(CompuertaDesicion,
        :id => 1,
        :compuerta_id => 2,
        :ruta_id => 3,
        :elegida => false
      ),
      stub_model(CompuertaDesicion,
        :id => 1,
        :compuerta_id => 2,
        :ruta_id => 3,
        :elegida => false
      )
    ])
  end

  it "renders a list of compuerta_desicions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
