require 'spec_helper'

describe "my_js_trees/index" do
  before(:each) do
    assign(:my_js_trees, [
      stub_model(MyJsTree,
        :parent_id => 1,
        :position => 2,
        :left => 3,
        :right => 4,
        :level => 5,
        :title => "Title",
        :type => "Type"
      ),
      stub_model(MyJsTree,
        :parent_id => 1,
        :position => 2,
        :left => 3,
        :right => 4,
        :level => 5,
        :title => "Title",
        :type => "Type"
      )
    ])
  end

  it "renders a list of my_js_trees" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
  end
end
