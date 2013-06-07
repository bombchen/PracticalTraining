require 'test_helper'

class StockingsControllerTest < ActionController::TestCase
  setup do
    @stocking = stockings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stockings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stocking" do
    assert_difference('Stocking.count') do
      post :create, stocking: { comments: @stocking.comments, end_time: @stocking.end_time, finished: @stocking.finished, owner_id: @stocking.owner_id, start_time: @stocking.start_time, title: @stocking.title }
    end

    assert_redirected_to stocking_path(assigns(:stocking))
  end

  test "should show stocking" do
    get :show, id: @stocking
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stocking
    assert_response :success
  end

  test "should update stocking" do
    put :update, id: @stocking, stocking: { comments: @stocking.comments, end_time: @stocking.end_time, finished: @stocking.finished, owner_id: @stocking.owner_id, start_time: @stocking.start_time, title: @stocking.title }
    assert_redirected_to stocking_path(assigns(:stocking))
  end

  test "should destroy stocking" do
    assert_difference('Stocking.count', -1) do
      delete :destroy, id: @stocking
    end

    assert_redirected_to stockings_path
  end
end
