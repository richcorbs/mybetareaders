require 'test_helper'

class ParagraphsControllerTest < ActionController::TestCase
  setup do
    @paragraph = paragraphs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paragraphs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paragraph" do
    assert_difference('Paragraph.count') do
      post :create, paragraph: { text: @paragraph.text, user_id: @paragraph.user_id }
    end

    assert_redirected_to paragraph_path(assigns(:paragraph))
  end

  test "should show paragraph" do
    get :show, id: @paragraph
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @paragraph
    assert_response :success
  end

  test "should update paragraph" do
    put :update, id: @paragraph, paragraph: { text: @paragraph.text, user_id: @paragraph.user_id }
    assert_redirected_to paragraph_path(assigns(:paragraph))
  end

  test "should destroy paragraph" do
    assert_difference('Paragraph.count', -1) do
      delete :destroy, id: @paragraph
    end

    assert_redirected_to paragraphs_path
  end
end
