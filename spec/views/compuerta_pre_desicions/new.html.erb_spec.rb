require 'spec_helper'

describe "compuerta_pre_desicions/new" do
  before(:each) do
    assign(:compuerta_pre_desicion, stub_model(CompuertaPreDesicion,
      :compuerta_id => 1,
      :ruta_id => 1,
      :elegida => false,
      :tarea_desicion_id => 1
    ).as_new_record)
  end

  it "renders new compuerta_pre_desicion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", compuerta_pre_desicions_path, "post" do
      assert_select "input#compuerta_pre_desicion_compuerta_id[name=?]", "compuerta_pre_desicion[compuerta_id]"
      assert_select "input#compuerta_pre_desicion_ruta_id[name=?]", "compuerta_pre_desicion[ruta_id]"
      assert_select "input#compuerta_pre_desicion_elegida[name=?]", "compuerta_pre_desicion[elegida]"
      assert_select "input#compuerta_pre_desicion_tarea_desicion_id[name=?]", "compuerta_pre_desicion[tarea_desicion_id]"
    end
  end
end
