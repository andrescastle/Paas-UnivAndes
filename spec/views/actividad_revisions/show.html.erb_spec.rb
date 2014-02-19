require 'spec_helper'

describe "actividad_revisions/show" do
  before(:each) do
    @actividad_revision = assign(:actividad_revision, stub_model(ActividadRevision,
      :id => 1,
      :nombre => "Nombre",
      :actividad_id => 2,
      :tipo_recurso_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Nombre/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
