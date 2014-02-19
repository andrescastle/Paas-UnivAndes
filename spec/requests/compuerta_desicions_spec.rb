require 'spec_helper'

describe "CompuertaDesicions" do
  describe "GET /compuerta_desicions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get compuerta_desicions_path
      response.status.should be(200)
    end
  end
end
