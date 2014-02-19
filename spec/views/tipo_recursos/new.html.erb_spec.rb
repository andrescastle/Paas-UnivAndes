require 'spec_helper'

describe "tipo_recursos/new" do
  before(:each) do
    assign(:tipo_recurso, stub_model(TipoRecurso,
      :nombre => "MyString"
    ).as_new_record)
  end

  it "renders new tipo_recurso form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tipo_recursos_path, :method => "post" do
      assert_select "input#tipo_recurso_nombre", :name => "tipo_recurso[nombre]"
    end
  end
end
