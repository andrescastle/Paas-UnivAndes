require 'spec_helper'

describe "tarea_recursos/show" do
  before(:each) do
    @tarea_recurso = assign(:tarea_recurso, stub_model(TareaRecurso,
      :id => 1,
      :tarea_id => 2,
      :recurso_id => 3,
      :esfuerzo => 4,
      :unidad_esfuerzo => 5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
  end
end
