require 'test_helper'

class ParagraphCommentsControllerTest < ActionController::TestCase
  setup do
    @paragraph_comment = paragraph_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paragraph_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paragraph_comment" do
    assert_difference('ParagraphComment.count') do
      post :create, paragraph_comment: { comment: @paragraph_comment.comment, paragraph_id: @paragraph_comment.paragraph_id, user_id: @paragraph_comment.user_id }
    end

    assert_redirected_to paragraph_comment_path(assigns(:paragraph_comment))
  end

  test "should show paragraph_comment" do
    get :show, id: @paragraph_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @paragraph_comment
    assert_response :success
  end

  test "should update paragraph_comment" do
    put :update, id: @paragraph_comment, paragraph_comment: { comment: @paragraph_comment.comment, paragraph_id: @paragraph_comment.paragraph_id, user_id: @paragraph_comment.user_id }
    assert_redirected_to paragraph_comment_path(assigns(:paragraph_comment))
  end

  test "should destroy paragraph_comment" do
    assert_difference('ParagraphComment.count', -1) do
      delete :destroy, id: @paragraph_comment
    end

    assert_redirected_to paragraph_comments_path
  end
end
