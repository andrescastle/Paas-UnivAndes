require 'spec_helper'

describe "tareas/edit" do
  before(:each) do
    @tarea = assign(:tarea, stub_model(Tarea,
      :id => 1,
      :nombre => "MyString",
      :descripcion => "MyString",
      :actividad_id => 1,
      :responsable_id => 1,
      :estado => "MyString",
      :prioridad => 1,
      :comentarios => "MyString",
      :avance => 1.5,
      :esfuerzo => 1,
      :unidad_esfuerzo => "MyString"
    ))
  end

  it "renders the edit tarea form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tareas_path(@tarea), :method => "post" do
      assert_select "input#tarea_id", :name => "tarea[id]"
      assert_select "input#tarea_nombre", :name => "tarea[nombre]"
      assert_select "input#tarea_descripcion", :name => "tarea[descripcion]"
      assert_select "input#tarea_actividad_id", :name => "tarea[actividad_id]"
      assert_select "input#tarea_responsable_id", :name => "tarea[responsable_id]"
      assert_select "input#tarea_estado", :name => "tarea[estado]"
      assert_select "input#tarea_prioridad", :name => "tarea[prioridad]"
      assert_select "input#tarea_comentarios", :name => "tarea[comentarios]"
      assert_select "input#tarea_avance", :name => "tarea[avance]"
      assert_select "input#tarea_esfuerzo", :name => "tarea[esfuerzo]"
      assert_select "input#tarea_unidad_esfuerzo", :name => "tarea[unidad_esfuerzo]"
    end
  end
end
