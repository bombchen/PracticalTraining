require 'test_helper'

class FacilityTotalsControllerTest < ActionController::TestCase
  setup do
    @facility_total = facility_totals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facility_totals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facility_total" do
    assert_difference('FacilityTotal.count') do
      post :create, facility_total: { facility_id: @facility_total.facility_id, total: @facility_total.total }
    end

    assert_redirected_to facility_total_path(assigns(:facility_total))
  end

  test "should show facility_total" do
    get :show, id: @facility_total
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facility_total
    assert_response :success
  end

  test "should update facility_total" do
    put :update, id: @facility_total, facility_total: { facility_id: @facility_total.facility_id, total: @facility_total.total }
    assert_redirected_to facility_total_path(assigns(:facility_total))
  end

  test "should destroy facility_total" do
    assert_difference('FacilityTotal.count', -1) do
      delete :destroy, id: @facility_total
    end

    assert_redirected_to facility_totals_path
  end
end
