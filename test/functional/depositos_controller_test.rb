require 'test_helper'

class DepositosControllerTest < ActionController::TestCase
  setup do
    @deposito = depositos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:depositos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deposito" do
    assert_difference('Deposito.count') do
      post :create, deposito: { contrasena: @deposito.contrasena, fcreado: @deposito.fcreado, nombre: @deposito.nombre, usuario: @deposito.usuario }
    end

    assert_redirected_to deposito_path(assigns(:deposito))
  end

  test "should show deposito" do
    get :show, id: @deposito
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @deposito
    assert_response :success
  end

  test "should update deposito" do
    put :update, id: @deposito, deposito: { contrasena: @deposito.contrasena, fcreado: @deposito.fcreado, nombre: @deposito.nombre, usuario: @deposito.usuario }
    assert_redirected_to deposito_path(assigns(:deposito))
  end

  test "should destroy deposito" do
    assert_difference('Deposito.count', -1) do
      delete :destroy, id: @deposito
    end

    assert_redirected_to depositos_path
  end
end
