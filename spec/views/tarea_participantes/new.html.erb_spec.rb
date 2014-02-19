require 'spec_helper'

describe "tarea_participantes/new" do
  before(:each) do
    assign(:tarea_participante, stub_model(TareaParticipante,
      :id => 1,
      :tarea_id => 1,
      :usuario_id => 1,
      :dedicacion => 1
    ).as_new_record)
  end

  it "renders new tarea_participante form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tarea_participantes_path, :method => "post" do
      assert_select "input#tarea_participante_id", :name => "tarea_participante[id]"
      assert_select "input#tarea_participante_tarea_id", :name => "tarea_participante[tarea_id]"
      assert_select "input#tarea_participante_usuario_id", :name => "tarea_participante[usuario_id]"
      assert_select "input#tarea_participante_dedicacion", :name => "tarea_participante[dedicacion]"
    end
  end
end
