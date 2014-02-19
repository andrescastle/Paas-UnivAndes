require 'spec_helper'

describe "tarea_recursos/new" do
  before(:each) do
    assign(:tarea_recurso, stub_model(TareaRecurso,
      :id => 1,
      :tarea_id => 1,
      :recurso_id => 1,
      :esfuerzo => 1,
      :unidad_esfuerzo => 1
    ).as_new_record)
  end

  it "renders new tarea_recurso form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tarea_recursos_path, :method => "post" do
      assert_select "input#tarea_recurso_id", :name => "tarea_recurso[id]"
      assert_select "input#tarea_recurso_tarea_id", :name => "tarea_recurso[tarea_id]"
      assert_select "input#tarea_recurso_recurso_id", :name => "tarea_recurso[recurso_id]"
      assert_select "input#tarea_recurso_esfuerzo", :name => "tarea_recurso[esfuerzo]"
      assert_select "input#tarea_recurso_unidad_esfuerzo", :name => "tarea_recurso[unidad_esfuerzo]"
    end
  end
end
