require 'spec_helper'

describe "compuerta_pre_desicions/index" do
  before(:each) do
    assign(:compuerta_pre_desicions, [
      stub_model(CompuertaPreDesicion,
        :compuerta_id => 1,
        :ruta_id => 2,
        :elegida => false,
        :tarea_desicion_id => 3
      ),
      stub_model(CompuertaPreDesicion,
        :compuerta_id => 1,
        :ruta_id => 2,
        :elegida => false,
        :tarea_desicion_id => 3
      )
    ])
  end

  it "renders a list of compuerta_pre_desicions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
