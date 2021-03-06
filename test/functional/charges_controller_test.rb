require 'test_helper'

class ChargesControllerTest < ActionController::TestCase
  setup do
    @charge = charges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:charges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create charge" do
    assert_difference('Charge.count') do
      post :create, charge: { amount: @charge.amount, amount_refunded: @charge.amount_refunded, amount_refunded: @charge.amount_refunded, customer_id: @charge.customer_id, document_id: @charge.document_id, failure_message: @charge.failure_message, paid: @charge.paid, refunded: @charge.refunded, stripe_charge_id: @charge.stripe_charge_id, stripe_fee: @charge.stripe_fee }
    end

    assert_redirected_to charge_path(assigns(:charge))
  end

  test "should show charge" do
    get :show, id: @charge
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @charge
    assert_response :success
  end

  test "should update charge" do
    put :update, id: @charge, charge: { amount: @charge.amount, amount_refunded: @charge.amount_refunded, amount_refunded: @charge.amount_refunded, customer_id: @charge.customer_id, document_id: @charge.document_id, failure_message: @charge.failure_message, paid: @charge.paid, refunded: @charge.refunded, stripe_charge_id: @charge.stripe_charge_id, stripe_fee: @charge.stripe_fee }
    assert_redirected_to charge_path(assigns(:charge))
  end

  test "should destroy charge" do
    assert_difference('Charge.count', -1) do
      delete :destroy, id: @charge
    end

    assert_redirected_to charges_path
  end
end
