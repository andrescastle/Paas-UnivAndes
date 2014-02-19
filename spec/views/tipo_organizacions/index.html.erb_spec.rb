require 'spec_helper'

describe "tipo_organizacions/index" do
  before(:each) do
    assign(:tipo_organizacions, [
      stub_model(TipoOrganizacion,
        :id => 1,
        :name => "Name"
      ),
      stub_model(TipoOrganizacion,
        :id => 1,
        :name => "Name"
      )
    ])
  end

  it "renders a list of tipo_organizacions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
