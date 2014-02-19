require 'spec_helper'

describe "tarea_artefactos/new" do
  before(:each) do
    assign(:tarea_artefacto, stub_model(TareaArtefacto,
      :id => 1,
      :tarea_id => 1,
      :artefacto_id => 1,
      :modo => "MyString"
    ).as_new_record)
  end

  it "renders new tarea_artefacto form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tarea_artefactos_path, :method => "post" do
      assert_select "input#tarea_artefacto_id", :name => "tarea_artefacto[id]"
      assert_select "input#tarea_artefacto_tarea_id", :name => "tarea_artefacto[tarea_id]"
      assert_select "input#tarea_artefacto_artefacto_id", :name => "tarea_artefacto[artefacto_id]"
      assert_select "input#tarea_artefacto_modo", :name => "tarea_artefacto[modo]"
    end
  end
end
