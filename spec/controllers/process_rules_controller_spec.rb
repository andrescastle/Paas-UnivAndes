require 'spec_helper'

describe ProcessRulesController do

  describe "GET 'validate_process'" do
    it "returns http success" do
      get 'validate_process'
      response.should be_success
    end
  end

end
