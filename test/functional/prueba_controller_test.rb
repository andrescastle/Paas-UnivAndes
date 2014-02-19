require 'test_helper'

class PruebaControllerTest < ActionController::TestCase
  test "should get prueba" do
    get :prueba
    assert_response :success
  end

end
