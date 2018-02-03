require 'test_helper'

class GmapsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gmap = gmaps(:one)
  end

  test "should get index" do
    get gmaps_url
    assert_response :success
  end

  test "should get new" do
    get new_gmap_url
    assert_response :success
  end

  test "should create gmap" do
    assert_difference('Gmap.count') do
      post gmaps_url, params: { gmap: { coment: @gmap.coment, latitude: @gmap.latitude, longitude: @gmap.longitude, magic_word: @gmap.magic_word, title: @gmap.title } }
    end

    assert_redirected_to gmap_url(Gmap.last)
  end

  test "should show gmap" do
    get gmap_url(@gmap)
    assert_response :success
  end

  test "should get edit" do
    get edit_gmap_url(@gmap)
    assert_response :success
  end

  test "should update gmap" do
    patch gmap_url(@gmap), params: { gmap: { coment: @gmap.coment, latitude: @gmap.latitude, longitude: @gmap.longitude, magic_word: @gmap.magic_word, title: @gmap.title } }
    assert_redirected_to gmap_url(@gmap)
  end

  test "should destroy gmap" do
    assert_difference('Gmap.count', -1) do
      delete gmap_url(@gmap)
    end

    assert_redirected_to gmaps_url
  end
end
