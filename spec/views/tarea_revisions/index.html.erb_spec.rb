require 'spec_helper'

describe "tarea_revisions/index" do
  before(:each) do
    assign(:tarea_revisions, [
      stub_model(TareaRevision,
        :id => 1,
        :tarea_id => 2,
        :usuario_id => 3,
        :comentario => "Comentario"
      ),
      stub_model(TareaRevision,
        :id => 1,
        :tarea_id => 2,
        :usuario_id => 3,
        :comentario => "Comentario"
      )
    ])
  end

  it "renders a list of tarea_revisions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Comentario".to_s, :count => 2
  end
end
