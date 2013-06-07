require 'test_helper'

class FacilityReturnsControllerTest < ActionController::TestCase
  setup do
    @facility_return = facility_returns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facility_returns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facility_return" do
    assert_difference('FacilityReturn.count') do
      post :create, facility_return: { application_id: @facility_return.application_id, comments: @facility_return.comments, returned: @facility_return.returned, status: @facility_return.status }
    end

    assert_redirected_to facility_return_path(assigns(:facility_return))
  end

  test "should show facility_return" do
    get :show, id: @facility_return
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facility_return
    assert_response :success
  end

  test "should update facility_return" do
    put :update, id: @facility_return, facility_return: { application_id: @facility_return.application_id, comments: @facility_return.comments, returned: @facility_return.returned, status: @facility_return.status }
    assert_redirected_to facility_return_path(assigns(:facility_return))
  end

  test "should destroy facility_return" do
    assert_difference('FacilityReturn.count', -1) do
      delete :destroy, id: @facility_return
    end

    assert_redirected_to facility_returns_path
  end
end
