require 'test_helper'

class TipoArchivosControllerTest < ActionController::TestCase
  setup do
    @tipo_archivo = tipo_archivos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_archivos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_archivo" do
    assert_difference('TipoArchivo.count') do
      post :create, tipo_archivo: { nombre: @tipo_archivo.nombre }
    end

    assert_redirected_to tipo_archivo_path(assigns(:tipo_archivo))
  end

  test "should show tipo_archivo" do
    get :show, id: @tipo_archivo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipo_archivo
    assert_response :success
  end

  test "should update tipo_archivo" do
    put :update, id: @tipo_archivo, tipo_archivo: { nombre: @tipo_archivo.nombre }
    assert_redirected_to tipo_archivo_path(assigns(:tipo_archivo))
  end

  test "should destroy tipo_archivo" do
    assert_difference('TipoArchivo.count', -1) do
      delete :destroy, id: @tipo_archivo
    end

    assert_redirected_to tipo_archivos_path
  end
end
