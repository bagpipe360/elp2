require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { created_at: @user.created_at, description: @user.description, first_name: @user.first_name, last_name: @user.last_name, profile_picture: @user.profile_picture, role: @user.role, verified_terms_and_service: @user.verified_terms_and_service }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { created_at: @user.created_at, description: @user.description, first_name: @user.first_name, last_name: @user.last_name, profile_picture: @user.profile_picture, role: @user.role, verified_terms_and_service: @user.verified_terms_and_service }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
