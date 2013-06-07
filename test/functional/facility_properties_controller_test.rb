require 'test_helper'

class FacilityPropertiesControllerTest < ActionController::TestCase
  setup do
    @facility_property = facility_properties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facility_properties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facility_property" do
    assert_difference('FacilityProperty.count') do
      post :create, facility_property: { facility_id: @facility_property.facility_id, property_name: @facility_property.property_name, property_value: @facility_property.property_value }
    end

    assert_redirected_to facility_property_path(assigns(:facility_property))
  end

  test "should show facility_property" do
    get :show, id: @facility_property
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facility_property
    assert_response :success
  end

  test "should update facility_property" do
    put :update, id: @facility_property, facility_property: { facility_id: @facility_property.facility_id, property_name: @facility_property.property_name, property_value: @facility_property.property_value }
    assert_redirected_to facility_property_path(assigns(:facility_property))
  end

  test "should destroy facility_property" do
    assert_difference('FacilityProperty.count', -1) do
      delete :destroy, id: @facility_property
    end

    assert_redirected_to facility_properties_path
  end
end
