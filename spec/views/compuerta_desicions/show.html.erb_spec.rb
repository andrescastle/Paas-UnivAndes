require 'spec_helper'

describe "compuerta_desicions/show" do
  before(:each) do
    @compuerta_desicion = assign(:compuerta_desicion, stub_model(CompuertaDesicion,
      :id => 1,
      :compuerta_id => 2,
      :ruta_id => 3,
      :elegida => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/false/)
  end
end
