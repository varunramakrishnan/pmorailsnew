require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  setup do
    @account = accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account" do
    assert_difference('Account.count') do
      post :create, account: { end_date: @account.end_date, organisational_unit_id: @account.organisational_unit_id, resource_allocated: @account.resource_allocated, resource_id: @account.resource_id, resource_needed: @account.resource_needed, start_date: @account.start_date, status: @account.status }
    end

    assert_redirected_to account_path(assigns(:account))
  end

  test "should show account" do
    get :show, id: @account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @account
    assert_response :success
  end

  test "should update account" do
    patch :update, id: @account, account: { end_date: @account.end_date, organisational_unit_id: @account.organisational_unit_id, resource_allocated: @account.resource_allocated, resource_id: @account.resource_id, resource_needed: @account.resource_needed, start_date: @account.start_date, status: @account.status }
    assert_redirected_to account_path(assigns(:account))
  end

  test "should destroy account" do
    assert_difference('Account.count', -1) do
      delete :destroy, id: @account
    end

    assert_redirected_to accounts_path
  end
end
