require 'spec_helper'

describe "actividad_revisions/new" do
  before(:each) do
    assign(:actividad_revision, stub_model(ActividadRevision,
      :id => 1,
      :nombre => "MyString",
      :actividad_id => 1,
      :tipo_recurso_id => 1
    ).as_new_record)
  end

  it "renders new actividad_revision form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => actividad_revisions_path, :method => "post" do
      assert_select "input#actividad_revision_id", :name => "actividad_revision[id]"
      assert_select "input#actividad_revision_nombre", :name => "actividad_revision[nombre]"
      assert_select "input#actividad_revision_actividad_id", :name => "actividad_revision[actividad_id]"
      assert_select "input#actividad_revision_tipo_recurso_id", :name => "actividad_revision[tipo_recurso_id]"
    end
  end
end
