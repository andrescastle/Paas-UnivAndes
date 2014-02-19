require 'spec_helper'

describe "tarea_presedencia/show" do
  before(:each) do
    @tarea_presedencium = assign(:tarea_presedencium, stub_model(TareaPresedencium,
      :predecesora_id => 1,
      :sucesora_id => 2,
      :tipo_relacion => "Tipo Relacion"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Tipo Relacion/)
  end
end
