require "test_helper"

class SongGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @song_group = song_groups(:one)
  end

  test "should get index" do
    get song_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_song_group_url
    assert_response :success
  end

  test "should create song_group" do
    assert_difference("SongGroup.count") do
      post song_groups_url, params: { song_group: {} }
    end

    assert_redirected_to song_group_url(SongGroup.last)
  end

  test "should show song_group" do
    get song_group_url(@song_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_song_group_url(@song_group)
    assert_response :success
  end

  test "should update song_group" do
    patch song_group_url(@song_group), params: { song_group: {} }
    assert_redirected_to song_group_url(@song_group)
  end

  test "should destroy song_group" do
    assert_difference("SongGroup.count", -1) do
      delete song_group_url(@song_group)
    end

    assert_redirected_to song_groups_url
  end
end
