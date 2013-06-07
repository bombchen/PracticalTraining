require 'test_helper'

class PracticeRecordsControllerTest < ActionController::TestCase
  setup do
    @practice_record = practice_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:practice_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create practice_record" do
    assert_difference('PracticeRecord.count') do
      post :create, practice_record: { course_id: @practice_record.course_id, record: @practice_record.record, review_comments: @practice_record.review_comments, status: @practice_record.status }
    end

    assert_redirected_to practice_record_path(assigns(:practice_record))
  end

  test "should show practice_record" do
    get :show, id: @practice_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @practice_record
    assert_response :success
  end

  test "should update practice_record" do
    put :update, id: @practice_record, practice_record: { course_id: @practice_record.course_id, record: @practice_record.record, review_comments: @practice_record.review_comments, status: @practice_record.status }
    assert_redirected_to practice_record_path(assigns(:practice_record))
  end

  test "should destroy practice_record" do
    assert_difference('PracticeRecord.count', -1) do
      delete :destroy, id: @practice_record
    end

    assert_redirected_to practice_records_path
  end
end
