require 'spec_helper'

describe "transicions/show" do
  before(:each) do
    @transicion = assign(:transicion, stub_model(Transicion,
      :id => 1,
      :nombre => "Nombre",
      :tipo_inicio => "Tipo Inicio",
      :incio_id => 2,
      :tipo_fin => "Tipo Fin",
      :fin_id => 3,
      :proceso_id => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Nombre/)
    rendered.should match(/Tipo Inicio/)
    rendered.should match(/2/)
    rendered.should match(/Tipo Fin/)
    rendered.should match(/3/)
    rendered.should match(/4/)
  end
end
