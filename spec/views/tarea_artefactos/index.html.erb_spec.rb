require 'spec_helper'

describe "tarea_artefactos/index" do
  before(:each) do
    assign(:tarea_artefactos, [
      stub_model(TareaArtefacto,
        :id => 1,
        :tarea_id => 2,
        :artefacto_id => 3,
        :modo => "Modo"
      ),
      stub_model(TareaArtefacto,
        :id => 1,
        :tarea_id => 2,
        :artefacto_id => 3,
        :modo => "Modo"
      )
    ])
  end

  it "renders a list of tarea_artefactos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Modo".to_s, :count => 2
  end
end
