require 'test_helper'

class RecordReviewsControllerTest < ActionController::TestCase
  setup do
    @record_review = record_reviews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:record_reviews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create record_review" do
    assert_difference('RecordReview.count') do
      post :create, record_review: { comments: @record_review.comments, record_id: @record_review.record_id, status: @record_review.status }
    end

    assert_redirected_to record_review_path(assigns(:record_review))
  end

  test "should show record_review" do
    get :show, id: @record_review
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @record_review
    assert_response :success
  end

  test "should update record_review" do
    put :update, id: @record_review, record_review: { comments: @record_review.comments, record_id: @record_review.record_id, status: @record_review.status }
    assert_redirected_to record_review_path(assigns(:record_review))
  end

  test "should destroy record_review" do
    assert_difference('RecordReview.count', -1) do
      delete :destroy, id: @record_review
    end

    assert_redirected_to record_reviews_path
  end
end
