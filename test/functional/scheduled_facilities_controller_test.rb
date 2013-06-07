require 'test_helper'

class ScheduledFacilitiesControllerTest < ActionController::TestCase
  setup do
    @scheduled_facility = scheduled_facilities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scheduled_facilities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scheduled_facility" do
    assert_difference('ScheduledFacility.count') do
      post :create, scheduled_facility: { facility_id: @scheduled_facility.facility_id, schedule_id: @scheduled_facility.schedule_id }
    end

    assert_redirected_to scheduled_facility_path(assigns(:scheduled_facility))
  end

  test "should show scheduled_facility" do
    get :show, id: @scheduled_facility
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scheduled_facility
    assert_response :success
  end

  test "should update scheduled_facility" do
    put :update, id: @scheduled_facility, scheduled_facility: { facility_id: @scheduled_facility.facility_id, schedule_id: @scheduled_facility.schedule_id }
    assert_redirected_to scheduled_facility_path(assigns(:scheduled_facility))
  end

  test "should destroy scheduled_facility" do
    assert_difference('ScheduledFacility.count', -1) do
      delete :destroy, id: @scheduled_facility
    end

    assert_redirected_to scheduled_facilities_path
  end
end
