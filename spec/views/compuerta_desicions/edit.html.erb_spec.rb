require 'spec_helper'

describe "compuerta_desicions/edit" do
  before(:each) do
    @compuerta_desicion = assign(:compuerta_desicion, stub_model(CompuertaDesicion,
      :id => 1,
      :compuerta_id => 1,
      :ruta_id => 1,
      :elegida => false
    ))
  end

  it "renders the edit compuerta_desicion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", compuerta_desicion_path(@compuerta_desicion), "post" do
      assert_select "input#compuerta_desicion_id[name=?]", "compuerta_desicion[id]"
      assert_select "input#compuerta_desicion_compuerta_id[name=?]", "compuerta_desicion[compuerta_id]"
      assert_select "input#compuerta_desicion_ruta_id[name=?]", "compuerta_desicion[ruta_id]"
      assert_select "input#compuerta_desicion_elegida[name=?]", "compuerta_desicion[elegida]"
    end
  end
end
