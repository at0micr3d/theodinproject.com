require 'test_helper'

class ScootersControllerTest < ActionController::TestCase
  setup do
    @scooter = scooters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scooters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scooter" do
    assert_difference('Scooter.count') do
      post :create, scooter: {  }
    end

    assert_redirected_to scooter_path(assigns(:scooter))
  end

  test "should show scooter" do
    get :show, id: @scooter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scooter
    assert_response :success
  end

  test "should update scooter" do
    patch :update, id: @scooter, scooter: {  }
    assert_redirected_to scooter_path(assigns(:scooter))
  end

  test "should destroy scooter" do
    assert_difference('Scooter.count', -1) do
      delete :destroy, id: @scooter
    end

    assert_redirected_to scooters_path
  end
end
