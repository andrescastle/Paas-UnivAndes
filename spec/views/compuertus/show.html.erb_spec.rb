require 'spec_helper'

describe "compuertus/show" do
  before(:each) do
    @compuertu = assign(:compuertu, stub_model(Compuertu,
      :nombre => "Nombre",
      :descripcion => "Descripcion",
      :tipo => 1,
      :desicion => 2,
      :plantilla => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    rendered.should match(/Descripcion/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(//)
  end
end
