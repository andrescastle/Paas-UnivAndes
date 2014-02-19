require 'spec_helper'

describe "tareas/index" do
  before(:each) do
    assign(:tareas, [
      stub_model(Tarea,
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
      ),
      stub_model(Tarea,
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
      )
    ])
  end

  it "renders a list of tareas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Estado".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Comentarios".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "Unidad Esfuerzo".to_s, :count => 2
  end
end
