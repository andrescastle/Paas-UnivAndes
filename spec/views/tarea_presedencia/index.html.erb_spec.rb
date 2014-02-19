require 'spec_helper'

describe "tarea_presedencia/index" do
  before(:each) do
    assign(:tarea_presedencia, [
      stub_model(TareaPresedencium,
        :predecesora_id => 1,
        :sucesora_id => 2,
        :tipo_relacion => "Tipo Relacion"
      ),
      stub_model(TareaPresedencium,
        :predecesora_id => 1,
        :sucesora_id => 2,
        :tipo_relacion => "Tipo Relacion"
      )
    ])
  end

  it "renders a list of tarea_presedencia" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Tipo Relacion".to_s, :count => 2
  end
end
