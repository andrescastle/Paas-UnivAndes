require 'spec_helper'

describe "tipo_organizacions/show" do
  before(:each) do
    @tipo_organizacion = assign(:tipo_organizacion, stub_model(TipoOrganizacion,
      :id => 1,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Name/)
  end
end
