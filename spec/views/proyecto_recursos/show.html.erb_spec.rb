require 'spec_helper'

describe "proyecto_recursos/show" do
  before(:each) do
    @proyecto_recurso = assign(:proyecto_recurso, stub_model(ProyectoRecurso,
      :proyecto_id => 1,
      :recurso_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
