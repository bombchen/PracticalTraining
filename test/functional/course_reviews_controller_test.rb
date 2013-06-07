require 'test_helper'

class CourseReviewsControllerTest < ActionController::TestCase
  setup do
    @course_review = course_reviews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_reviews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_review" do
    assert_difference('CourseReview.count') do
      post :create, course_review: { comments: @course_review.comments, course_id: @course_review.course_id, status: @course_review.status }
    end

    assert_redirected_to course_review_path(assigns(:course_review))
  end

  test "should show course_review" do
    get :show, id: @course_review
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course_review
    assert_response :success
  end

  test "should update course_review" do
    put :update, id: @course_review, course_review: { comments: @course_review.comments, course_id: @course_review.course_id, status: @course_review.status }
    assert_redirected_to course_review_path(assigns(:course_review))
  end

  test "should destroy course_review" do
    assert_difference('CourseReview.count', -1) do
      delete :destroy, id: @course_review
    end

    assert_redirected_to course_reviews_path
  end
end
