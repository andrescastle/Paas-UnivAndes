require 'test_helper'

class TipoDepositosControllerTest < ActionController::TestCase
  setup do
    @tipo_deposito = tipo_depositos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_depositos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_deposito" do
    assert_difference('TipoDeposito.count') do
      post :create, tipo_deposito: { nombre: @tipo_deposito.nombre }
    end

    assert_redirected_to tipo_deposito_path(assigns(:tipo_deposito))
  end

  test "should show tipo_deposito" do
    get :show, id: @tipo_deposito
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipo_deposito
    assert_response :success
  end

  test "should update tipo_deposito" do
    put :update, id: @tipo_deposito, tipo_deposito: { nombre: @tipo_deposito.nombre }
    assert_redirected_to tipo_deposito_path(assigns(:tipo_deposito))
  end

  test "should destroy tipo_deposito" do
    assert_difference('TipoDeposito.count', -1) do
      delete :destroy, id: @tipo_deposito
    end

    assert_redirected_to tipo_depositos_path
  end
end
