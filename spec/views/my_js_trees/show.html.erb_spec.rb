require 'spec_helper'

describe "my_js_trees/show" do
  before(:each) do
    @my_js_tree = assign(:my_js_tree, stub_model(MyJsTree,
      :parent_id => 1,
      :position => 2,
      :left => 3,
      :right => 4,
      :level => 5,
      :title => "Title",
      :type => "Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/Title/)
    rendered.should match(/Type/)
  end
end
