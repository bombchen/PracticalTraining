require 'test_helper'

class FacilityApplicationsControllerTest < ActionController::TestCase
  setup do
    @facility_application = facility_applications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facility_applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facility_application" do
    assert_difference('FacilityApplication.count') do
      post :create, facility_application: { applied: @facility_application.applied, course_id: @facility_application.course_id, facility_id: @facility_application.facility_id, returned: @facility_application.returned, review_comments: @facility_application.review_comments, status: @facility_application.status }
    end

    assert_redirected_to facility_application_path(assigns(:facility_application))
  end

  test "should show facility_application" do
    get :show, id: @facility_application
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facility_application
    assert_response :success
  end

  test "should update facility_application" do
    put :update, id: @facility_application, facility_application: { applied: @facility_application.applied, course_id: @facility_application.course_id, facility_id: @facility_application.facility_id, returned: @facility_application.returned, review_comments: @facility_application.review_comments, status: @facility_application.status }
    assert_redirected_to facility_application_path(assigns(:facility_application))
  end

  test "should destroy facility_application" do
    assert_difference('FacilityApplication.count', -1) do
      delete :destroy, id: @facility_application
    end

    assert_redirected_to facility_applications_path
  end
end
