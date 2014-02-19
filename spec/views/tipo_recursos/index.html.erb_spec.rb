require 'spec_helper'

describe "tipo_recursos/index" do
  before(:each) do
    assign(:tipo_recursos, [
      stub_model(TipoRecurso,
        :nombre => "Nombre"
      ),
      stub_model(TipoRecurso,
        :nombre => "Nombre"
      )
    ])
  end

  it "renders a list of tipo_recursos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
  end
end
