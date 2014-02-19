require 'test_helper'

class ArchivoProyectosControllerTest < ActionController::TestCase
  setup do
    @archivo_proyecto = archivo_proyectos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:archivo_proyectos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create archivo_proyecto" do
    assert_difference('ArchivoProyecto.count') do
      post :create, archivo_proyecto: {  }
    end

    assert_redirected_to archivo_proyecto_path(assigns(:archivo_proyecto))
  end

  test "should show archivo_proyecto" do
    get :show, id: @archivo_proyecto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @archivo_proyecto
    assert_response :success
  end

  test "should update archivo_proyecto" do
    put :update, id: @archivo_proyecto, archivo_proyecto: {  }
    assert_redirected_to archivo_proyecto_path(assigns(:archivo_proyecto))
  end

  test "should destroy archivo_proyecto" do
    assert_difference('ArchivoProyecto.count', -1) do
      delete :destroy, id: @archivo_proyecto
    end

    assert_redirected_to archivo_proyectos_path
  end
end
