require 'spec_helper'

describe "tarea_recursos/index" do
  before(:each) do
    assign(:tarea_recursos, [
      stub_model(TareaRecurso,
        :id => 1,
        :tarea_id => 2,
        :recurso_id => 3,
        :esfuerzo => 4,
        :unidad_esfuerzo => 5
      ),
      stub_model(TareaRecurso,
        :id => 1,
        :tarea_id => 2,
        :recurso_id => 3,
        :esfuerzo => 4,
        :unidad_esfuerzo => 5
      )
    ])
  end

  it "renders a list of tarea_recursos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
