require 'spec_helper'

describe "tarea_participantes/show" do
  before(:each) do
    @tarea_participante = assign(:tarea_participante, stub_model(TareaParticipante,
      :id => 1,
      :tarea_id => 2,
      :usuario_id => 3,
      :dedicacion => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
  end
end
