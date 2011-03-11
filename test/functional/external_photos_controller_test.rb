require 'test_helper'

class ExternalPhotosControllerTest < ActionController::TestCase
  setup do
    @external_photo = external_photos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:external_photos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create external_photo" do
    assert_difference('ExternalPhoto.count') do
      post :create, :external_photo => @external_photo.attributes
    end

    assert_redirected_to external_photo_path(assigns(:external_photo))
  end

  test "should show external_photo" do
    get :show, :id => @external_photo.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @external_photo.to_param
    assert_response :success
  end

  test "should update external_photo" do
    put :update, :id => @external_photo.to_param, :external_photo => @external_photo.attributes
    assert_redirected_to external_photo_path(assigns(:external_photo))
  end

  test "should destroy external_photo" do
    assert_difference('ExternalPhoto.count', -1) do
      delete :destroy, :id => @external_photo.to_param
    end

    assert_redirected_to external_photos_path
  end
end
