require 'spec_helper'

describe "actividads/show" do
  before(:each) do
    @actividad = assign(:actividad, stub_model(Actividad,
      :nombre => "Nombre",
      :descripcion => "Descripcion",
      :modoejecucion => 1,
      :plantilla => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    rendered.should match(/Descripcion/)
    rendered.should match(/1/)
    rendered.should match(//)
  end
end
