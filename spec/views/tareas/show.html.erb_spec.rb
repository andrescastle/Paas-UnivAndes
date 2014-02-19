require 'spec_helper'

describe "tareas/show" do
  before(:each) do
    @tarea = assign(:tarea, stub_model(Tarea,
      :id => 1,
      :nombre => "Nombre",
      :descripcion => "Descripcion",
      :actividad_id => 2,
      :responsable_id => 3,
      :estado => "Estado",
      :prioridad => 4,
      :comentarios => "Comentarios",
      :avance => 1.5,
      :esfuerzo => 5,
      :unidad_esfuerzo => "Unidad Esfuerzo"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Nombre/)
    rendered.should match(/Descripcion/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Estado/)
    rendered.should match(/4/)
    rendered.should match(/Comentarios/)
    rendered.should match(/1.5/)
    rendered.should match(/5/)
    rendered.should match(/Unidad Esfuerzo/)
  end
end
