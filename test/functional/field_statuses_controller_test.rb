require 'test_helper'

class FieldStatusesControllerTest < ActionController::TestCase
  setup do
    @field_status = field_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:field_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create field_status" do
    assert_difference('FieldStatus.count') do
      post :create, field_status: { available: @field_status.available, name: @field_status.name, systematic: @field_status.systematic }
    end

    assert_redirected_to field_status_path(assigns(:field_status))
  end

  test "should show field_status" do
    get :show, id: @field_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @field_status
    assert_response :success
  end

  test "should update field_status" do
    put :update, id: @field_status, field_status: { available: @field_status.available, name: @field_status.name, systematic: @field_status.systematic }
    assert_redirected_to field_status_path(assigns(:field_status))
  end

  test "should destroy field_status" do
    assert_difference('FieldStatus.count', -1) do
      delete :destroy, id: @field_status
    end

    assert_redirected_to field_statuses_path
  end
end
