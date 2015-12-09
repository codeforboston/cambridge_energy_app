require 'test_helper'

class UserBuildingsControllerTest < ActionController::TestCase
  setup do
    @user_building = user_buildings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_buildings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_building" do
    assert_difference('UserBuilding.count') do
      post :create, user_building: { address: @user_building.address, lat: @user_building.lat, lon: @user_building.lon }
    end

    assert_redirected_to user_building_path(assigns(:user_building))
  end

  test "should show user_building" do
    get :show, id: @user_building
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_building
    assert_response :success
  end

  test "should update user_building" do
    patch :update, id: @user_building, user_building: { address: @user_building.address, lat: @user_building.lat, lon: @user_building.lon }
    assert_redirected_to user_building_path(assigns(:user_building))
  end

  test "should destroy user_building" do
    assert_difference('UserBuilding.count', -1) do
      delete :destroy, id: @user_building
    end

    assert_redirected_to user_buildings_path
  end
end
