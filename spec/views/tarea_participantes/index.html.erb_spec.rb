require 'spec_helper'

describe "tarea_participantes/index" do
  before(:each) do
    assign(:tarea_participantes, [
      stub_model(TareaParticipante,
        :id => 1,
        :tarea_id => 2,
        :usuario_id => 3,
        :dedicacion => 4
      ),
      stub_model(TareaParticipante,
        :id => 1,
        :tarea_id => 2,
        :usuario_id => 3,
        :dedicacion => 4
      )
    ])
  end

  it "renders a list of tarea_participantes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
