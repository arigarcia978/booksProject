require 'test_helper'

class ReviewingsControllerTest < ActionController::TestCase
  setup do
    @reviewing = reviewings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reviewings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reviewing" do
    assert_difference('Reviewing.count') do
      post :create, reviewing: { book_id: @reviewing.book_id, rate: @reviewing.rate, review: @reviewing.review, user_id: @reviewing.user_id }
    end

    assert_redirected_to reviewing_path(assigns(:reviewing))
  end

  test "should show reviewing" do
    get :show, id: @reviewing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reviewing
    assert_response :success
  end

  test "should update reviewing" do
    patch :update, id: @reviewing, reviewing: { book_id: @reviewing.book_id, rate: @reviewing.rate, review: @reviewing.review, user_id: @reviewing.user_id }
    assert_redirected_to reviewing_path(assigns(:reviewing))
  end

  test "should destroy reviewing" do
    assert_difference('Reviewing.count', -1) do
      delete :destroy, id: @reviewing
    end

    assert_redirected_to reviewings_path
  end
end
