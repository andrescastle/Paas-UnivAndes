require 'spec_helper'

describe "tipo_recursos/edit" do
  before(:each) do
    @tipo_recurso = assign(:tipo_recurso, stub_model(TipoRecurso,
      :nombre => "MyString"
    ))
  end

  it "renders the edit tipo_recurso form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tipo_recursos_path(@tipo_recurso), :method => "post" do
      assert_select "input#tipo_recurso_nombre", :name => "tipo_recurso[nombre]"
    end
  end
end
