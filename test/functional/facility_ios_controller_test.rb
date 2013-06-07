require 'test_helper'

class FacilityIosControllerTest < ActionController::TestCase
  setup do
    @facility_io = facility_ios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facility_ios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facility_io" do
    assert_difference('FacilityIo.count') do
      post :create, facility_io: { amount: @facility_io.amount, date: @facility_io.date, facility_id: @facility_io.facility_id, owner_id: @facility_io.owner_id, reason_id: @facility_io.reason_id }
    end

    assert_redirected_to facility_io_path(assigns(:facility_io))
  end

  test "should show facility_io" do
    get :show, id: @facility_io
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facility_io
    assert_response :success
  end

  test "should update facility_io" do
    put :update, id: @facility_io, facility_io: { amount: @facility_io.amount, date: @facility_io.date, facility_id: @facility_io.facility_id, owner_id: @facility_io.owner_id, reason_id: @facility_io.reason_id }
    assert_redirected_to facility_io_path(assigns(:facility_io))
  end

  test "should destroy facility_io" do
    assert_difference('FacilityIo.count', -1) do
      delete :destroy, id: @facility_io
    end

    assert_redirected_to facility_ios_path
  end
end
