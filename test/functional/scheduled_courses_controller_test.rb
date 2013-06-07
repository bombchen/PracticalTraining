require 'test_helper'

class ScheduledCoursesControllerTest < ActionController::TestCase
  setup do
    @scheduled_course = scheduled_courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scheduled_courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scheduled_course" do
    assert_difference('ScheduledCourse.count') do
      post :create, scheduled_course: { begin_date: @scheduled_course.begin_date, class: @scheduled_course.class, end_date: @scheduled_course.end_date, idx: @scheduled_course.idx, room: @scheduled_course.room, teacher_id: @scheduled_course.teacher_id, teacher_name: @scheduled_course.teacher_name, title: @scheduled_course.title, weekday: @scheduled_course.weekday }
    end

    assert_redirected_to scheduled_course_path(assigns(:scheduled_course))
  end

  test "should show scheduled_course" do
    get :show, id: @scheduled_course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scheduled_course
    assert_response :success
  end

  test "should update scheduled_course" do
    put :update, id: @scheduled_course, scheduled_course: { begin_date: @scheduled_course.begin_date, class: @scheduled_course.class, end_date: @scheduled_course.end_date, idx: @scheduled_course.idx, room: @scheduled_course.room, teacher_id: @scheduled_course.teacher_id, teacher_name: @scheduled_course.teacher_name, title: @scheduled_course.title, weekday: @scheduled_course.weekday }
    assert_redirected_to scheduled_course_path(assigns(:scheduled_course))
  end

  test "should destroy scheduled_course" do
    assert_difference('ScheduledCourse.count', -1) do
      delete :destroy, id: @scheduled_course
    end

    assert_redirected_to scheduled_courses_path
  end
end
