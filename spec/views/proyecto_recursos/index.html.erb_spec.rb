require 'spec_helper'

describe "proyecto_recursos/index" do
  before(:each) do
    assign(:proyecto_recursos, [
      stub_model(ProyectoRecurso,
        :proyecto_id => 1,
        :recurso_id => 2
      ),
      stub_model(ProyectoRecurso,
        :proyecto_id => 1,
        :recurso_id => 2
      )
    ])
  end

  it "renders a list of proyecto_recursos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
