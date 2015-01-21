require 'test_helper'

class InterviewQuestionsControllerTest < ActionController::TestCase
  setup do
    @interview_question = interview_questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:interview_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create interview_question" do
    assert_difference('InterviewQuestion.count') do
      post :create, interview_question: { question: @interview_question.question, question_id: @interview_question.question_id }
    end

    assert_redirected_to interview_question_path(assigns(:interview_question))
  end

  test "should show interview_question" do
    get :show, id: @interview_question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @interview_question
    assert_response :success
  end

  test "should update interview_question" do
    put :update, id: @interview_question, interview_question: { question: @interview_question.question, question_id: @interview_question.question_id }
    assert_redirected_to interview_question_path(assigns(:interview_question))
  end

  test "should destroy interview_question" do
    assert_difference('InterviewQuestion.count', -1) do
      delete :destroy, id: @interview_question
    end

    assert_redirected_to interview_questions_path
  end
end
