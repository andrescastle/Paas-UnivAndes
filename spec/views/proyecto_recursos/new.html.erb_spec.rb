require 'spec_helper'

describe "proyecto_recursos/new" do
  before(:each) do
    assign(:proyecto_recurso, stub_model(ProyectoRecurso,
      :proyecto_id => 1,
      :recurso_id => 1
    ).as_new_record)
  end

  it "renders new proyecto_recurso form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => proyecto_recursos_path, :method => "post" do
      assert_select "input#proyecto_recurso_proyecto_id", :name => "proyecto_recurso[proyecto_id]"
      assert_select "input#proyecto_recurso_recurso_id", :name => "proyecto_recurso[recurso_id]"
    end
  end
end
