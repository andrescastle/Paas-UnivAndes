require 'test_helper'

class DepositoProyectosControllerTest < ActionController::TestCase
  setup do
    @deposito_proyecto = deposito_proyectos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deposito_proyectos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deposito_proyecto" do
    assert_difference('DepositoProyecto.count') do
      post :create, deposito_proyecto: {  }
    end

    assert_redirected_to deposito_proyecto_path(assigns(:deposito_proyecto))
  end

  test "should show deposito_proyecto" do
    get :show, id: @deposito_proyecto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @deposito_proyecto
    assert_response :success
  end

  test "should update deposito_proyecto" do
    put :update, id: @deposito_proyecto, deposito_proyecto: {  }
    assert_redirected_to deposito_proyecto_path(assigns(:deposito_proyecto))
  end

  test "should destroy deposito_proyecto" do
    assert_difference('DepositoProyecto.count', -1) do
      delete :destroy, id: @deposito_proyecto
    end

    assert_redirected_to deposito_proyectos_path
  end
end
