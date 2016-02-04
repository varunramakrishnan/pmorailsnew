require 'test_helper'

class HeirarchiesControllerTest < ActionController::TestCase
  setup do
    @heirarchy = heirarchies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:heirarchies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create heirarchy" do
    assert_difference('Heirarchy.count') do
      post :create, heirarchy: { heirarchy_name: @heirarchy.heirarchy_name }
    end

    assert_redirected_to heirarchy_path(assigns(:heirarchy))
  end

  test "should show heirarchy" do
    get :show, id: @heirarchy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @heirarchy
    assert_response :success
  end

  test "should update heirarchy" do
    patch :update, id: @heirarchy, heirarchy: { heirarchy_name: @heirarchy.heirarchy_name }
    assert_redirected_to heirarchy_path(assigns(:heirarchy))
  end

  test "should destroy heirarchy" do
    assert_difference('Heirarchy.count', -1) do
      delete :destroy, id: @heirarchy
    end

    assert_redirected_to heirarchies_path
  end
end
