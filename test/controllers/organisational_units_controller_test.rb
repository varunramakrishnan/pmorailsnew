require 'test_helper'

class OrganisationalUnitsControllerTest < ActionController::TestCase
  setup do
    @organisational_unit = organisational_units(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organisational_units)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create organisational_unit" do
    assert_difference('OrganisationalUnit.count') do
      post :create, organisational_unit: { unit_name: @organisational_unit.unit_name }
    end

    assert_redirected_to organisational_unit_path(assigns(:organisational_unit))
  end

  test "should show organisational_unit" do
    get :show, id: @organisational_unit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @organisational_unit
    assert_response :success
  end

  test "should update organisational_unit" do
    patch :update, id: @organisational_unit, organisational_unit: { unit_name: @organisational_unit.unit_name }
    assert_redirected_to organisational_unit_path(assigns(:organisational_unit))
  end

  test "should destroy organisational_unit" do
    assert_difference('OrganisationalUnit.count', -1) do
      delete :destroy, id: @organisational_unit
    end

    assert_redirected_to organisational_units_path
  end
end
