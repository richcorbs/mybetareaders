require 'test_helper'

class ParagraphRatingsControllerTest < ActionController::TestCase
  setup do
    @paragraph_rating = paragraph_ratings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paragraph_ratings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paragraph_rating" do
    assert_difference('ParagraphRating.count') do
      post :create, paragraph_rating: { character: @paragraph_rating.character, pace: @paragraph_rating.pace, paragraph_id: @paragraph_rating.paragraph_id, plot: @paragraph_rating.plot, user_id: @paragraph_rating.user_id }
    end

    assert_redirected_to paragraph_rating_path(assigns(:paragraph_rating))
  end

  test "should show paragraph_rating" do
    get :show, id: @paragraph_rating
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @paragraph_rating
    assert_response :success
  end

  test "should update paragraph_rating" do
    put :update, id: @paragraph_rating, paragraph_rating: { character: @paragraph_rating.character, pace: @paragraph_rating.pace, paragraph_id: @paragraph_rating.paragraph_id, plot: @paragraph_rating.plot, user_id: @paragraph_rating.user_id }
    assert_redirected_to paragraph_rating_path(assigns(:paragraph_rating))
  end

  test "should destroy paragraph_rating" do
    assert_difference('ParagraphRating.count', -1) do
      delete :destroy, id: @paragraph_rating
    end

    assert_redirected_to paragraph_ratings_path
  end
end
