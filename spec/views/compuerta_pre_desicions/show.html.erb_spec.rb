require 'spec_helper'

describe "compuerta_pre_desicions/show" do
  before(:each) do
    @compuerta_pre_desicion = assign(:compuerta_pre_desicion, stub_model(CompuertaPreDesicion,
      :compuerta_id => 1,
      :ruta_id => 2,
      :elegida => false,
      :tarea_desicion_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/false/)
    rendered.should match(/3/)
  end
end
