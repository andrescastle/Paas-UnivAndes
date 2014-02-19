require 'spec_helper'

describe "tipo_recursos/show" do
  before(:each) do
    @tipo_recurso = assign(:tipo_recurso, stub_model(TipoRecurso,
      :nombre => "Nombre"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
  end
end
