require 'spec_helper'

describe "my_js_trees/edit" do
  before(:each) do
    @my_js_tree = assign(:my_js_tree, stub_model(MyJsTree,
      :parent_id => 1,
      :position => 1,
      :left => 1,
      :right => 1,
      :level => 1,
      :title => "MyString",
      :type => ""
    ))
  end

  it "renders the edit my_js_tree form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => my_js_trees_path(@my_js_tree), :method => "post" do
      assert_select "input#my_js_tree_parent_id", :name => "my_js_tree[parent_id]"
      assert_select "input#my_js_tree_position", :name => "my_js_tree[position]"
      assert_select "input#my_js_tree_left", :name => "my_js_tree[left]"
      assert_select "input#my_js_tree_right", :name => "my_js_tree[right]"
      assert_select "input#my_js_tree_level", :name => "my_js_tree[level]"
      assert_select "input#my_js_tree_title", :name => "my_js_tree[title]"
      assert_select "input#my_js_tree_type", :name => "my_js_tree[type]"
    end
  end
end
