require 'test_helper'

class UserRoleMappingsControllerTest < ActionController::TestCase
  setup do
    @user_role_mapping = user_role_mappings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_role_mappings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_role_mapping" do
    assert_difference('UserRoleMapping.count') do
      post :create, user_role_mapping: { role_id: @user_role_mapping.role_id, user_id: @user_role_mapping.user_id }
    end

    assert_redirected_to user_role_mapping_path(assigns(:user_role_mapping))
  end

  test "should show user_role_mapping" do
    get :show, id: @user_role_mapping
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_role_mapping
    assert_response :success
  end

  test "should update user_role_mapping" do
    put :update, id: @user_role_mapping, user_role_mapping: { role_id: @user_role_mapping.role_id, user_id: @user_role_mapping.user_id }
    assert_redirected_to user_role_mapping_path(assigns(:user_role_mapping))
  end

  test "should destroy user_role_mapping" do
    assert_difference('UserRoleMapping.count', -1) do
      delete :destroy, id: @user_role_mapping
    end

    assert_redirected_to user_role_mappings_path
  end
end
