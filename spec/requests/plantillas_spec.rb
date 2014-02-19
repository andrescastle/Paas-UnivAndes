require 'spec_helper'

describe "Plantillas" do
  describe "GET /plantillas" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get plantillas_path
      response.status.should be(200)
    end
  end
end
