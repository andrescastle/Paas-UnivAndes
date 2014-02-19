require 'spec_helper'

describe "tarea_presedencia/new" do
  before(:each) do
    assign(:tarea_presedencium, stub_model(TareaPresedencium,
      :predecesora_id => 1,
      :sucesora_id => 1,
      :tipo_relacion => "MyString"
    ).as_new_record)
  end

  it "renders new tarea_presedencium form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tarea_presedencia_path, :method => "post" do
      assert_select "input#tarea_presedencium_predecesora_id", :name => "tarea_presedencium[predecesora_id]"
      assert_select "input#tarea_presedencium_sucesora_id", :name => "tarea_presedencium[sucesora_id]"
      assert_select "input#tarea_presedencium_tipo_relacion", :name => "tarea_presedencium[tipo_relacion]"
    end
  end
end
