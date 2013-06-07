require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get instore" do
    get :instore
    assert_response :success
  end

  test "should get consume" do
    get :consume
    assert_response :success
  end

  test "should get lost" do
    get :lost
    assert_response :success
  end

  test "should get category" do
    get :category
    assert_response :success
  end

  test "should get department" do
    get :department
    assert_response :success
  end

  test "should get teacher" do
    get :teacher
    assert_response :success
  end

  test "should get overall" do
    get :overall
    assert_response :success
  end

end
