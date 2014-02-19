require 'spec_helper'

describe "CompuertaPreDesicions" do
  describe "GET /compuerta_pre_desicions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get compuerta_pre_desicions_path
      response.status.should be(200)
    end
  end
end
