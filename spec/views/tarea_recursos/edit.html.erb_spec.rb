require 'spec_helper'

describe "tarea_recursos/edit" do
  before(:each) do
    @tarea_recurso = assign(:tarea_recurso, stub_model(TareaRecurso,
      :id => 1,
      :tarea_id => 1,
      :recurso_id => 1,
      :esfuerzo => 1,
      :unidad_esfuerzo => 1
    ))
  end

  it "renders the edit tarea_recurso form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tarea_recursos_path(@tarea_recurso), :method => "post" do
      assert_select "input#tarea_recurso_id", :name => "tarea_recurso[id]"
      assert_select "input#tarea_recurso_tarea_id", :name => "tarea_recurso[tarea_id]"
      assert_select "input#tarea_recurso_recurso_id", :name => "tarea_recurso[recurso_id]"
      assert_select "input#tarea_recurso_esfuerzo", :name => "tarea_recurso[esfuerzo]"
      assert_select "input#tarea_recurso_unidad_esfuerzo", :name => "tarea_recurso[unidad_esfuerzo]"
    end
  end
end
