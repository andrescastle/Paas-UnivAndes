require 'spec_helper'

describe "tarea_artefactos/show" do
  before(:each) do
    @tarea_artefacto = assign(:tarea_artefacto, stub_model(TareaArtefacto,
      :id => 1,
      :tarea_id => 2,
      :artefacto_id => 3,
      :modo => "Modo"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Modo/)
  end
end
