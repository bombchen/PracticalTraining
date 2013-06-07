require 'test_helper'

class FacilityCategoriesControllerTest < ActionController::TestCase
  setup do
    @facility_category = facility_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facility_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facility_category" do
    assert_difference('FacilityCategory.count') do
      post :create, facility_category: { comments: @facility_category.comments, name: @facility_category.name }
    end

    assert_redirected_to facility_category_path(assigns(:facility_category))
  end

  test "should show facility_category" do
    get :show, id: @facility_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facility_category
    assert_response :success
  end

  test "should update facility_category" do
    put :update, id: @facility_category, facility_category: { comments: @facility_category.comments, name: @facility_category.name }
    assert_redirected_to facility_category_path(assigns(:facility_category))
  end

  test "should destroy facility_category" do
    assert_difference('FacilityCategory.count', -1) do
      delete :destroy, id: @facility_category
    end

    assert_redirected_to facility_categories_path
  end
end
