require 'test_helper'

class FacilityReasonsControllerTest < ActionController::TestCase
  setup do
    @facility_reason = facility_reasons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facility_reasons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facility_reason" do
    assert_difference('FacilityReason.count') do
      post :create, facility_reason: { if_add: @facility_reason.if_add, reason: @facility_reason.reason }
    end

    assert_redirected_to facility_reason_path(assigns(:facility_reason))
  end

  test "should show facility_reason" do
    get :show, id: @facility_reason
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facility_reason
    assert_response :success
  end

  test "should update facility_reason" do
    put :update, id: @facility_reason, facility_reason: { if_add: @facility_reason.if_add, reason: @facility_reason.reason }
    assert_redirected_to facility_reason_path(assigns(:facility_reason))
  end

  test "should destroy facility_reason" do
    assert_difference('FacilityReason.count', -1) do
      delete :destroy, id: @facility_reason
    end

    assert_redirected_to facility_reasons_path
  end
end
