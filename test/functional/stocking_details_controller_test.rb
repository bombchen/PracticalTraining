require 'test_helper'

class StockingDetailsControllerTest < ActionController::TestCase
  setup do
    @stocking_detail = stocking_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stocking_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stocking_detail" do
    assert_difference('StockingDetail.count') do
      post :create, stocking_detail: { facility_id: @stocking_detail.facility_id, new_amount: @stocking_detail.new_amount, old_amount: @stocking_detail.old_amount, stocking_id: @stocking_detail.stocking_id }
    end

    assert_redirected_to stocking_detail_path(assigns(:stocking_detail))
  end

  test "should show stocking_detail" do
    get :show, id: @stocking_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stocking_detail
    assert_response :success
  end

  test "should update stocking_detail" do
    put :update, id: @stocking_detail, stocking_detail: { facility_id: @stocking_detail.facility_id, new_amount: @stocking_detail.new_amount, old_amount: @stocking_detail.old_amount, stocking_id: @stocking_detail.stocking_id }
    assert_redirected_to stocking_detail_path(assigns(:stocking_detail))
  end

  test "should destroy stocking_detail" do
    assert_difference('StockingDetail.count', -1) do
      delete :destroy, id: @stocking_detail
    end

    assert_redirected_to stocking_details_path
  end
end
