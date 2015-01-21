require 'test_helper'

class LessonsControllerTest < ActionController::TestCase
  setup do
    @lesson = lessons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lessons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lesson" do
    assert_difference('Lesson.count') do
      post :create, lesson: { end_time: @lesson.end_time, rounded_time: @lesson.rounded_time, session_id: @lesson.session_id, start_time: @lesson.start_time, student_id: @lesson.student_id, student_paid: @lesson.student_paid, teacher_id: @lesson.teacher_id, teacher_paid: @lesson.teacher_paid, time_slot_id: @lesson.time_slot_id, token: @lesson.token }
    end

    assert_redirected_to lesson_path(assigns(:lesson))
  end

  test "should show lesson" do
    get :show, id: @lesson
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lesson
    assert_response :success
  end

  test "should update lesson" do
    put :update, id: @lesson, lesson: { end_time: @lesson.end_time, rounded_time: @lesson.rounded_time, session_id: @lesson.session_id, start_time: @lesson.start_time, student_id: @lesson.student_id, student_paid: @lesson.student_paid, teacher_id: @lesson.teacher_id, teacher_paid: @lesson.teacher_paid, time_slot_id: @lesson.time_slot_id, token: @lesson.token }
    assert_redirected_to lesson_path(assigns(:lesson))
  end

  test "should destroy lesson" do
    assert_difference('Lesson.count', -1) do
      delete :destroy, id: @lesson
    end

    assert_redirected_to lessons_path
  end
end
