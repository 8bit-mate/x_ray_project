require "test_helper"

class SongTitlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @song_title = song_titles(:one)
  end

  test "should get index" do
    get song_titles_url
    assert_response :success
  end

  test "should get new" do
    get new_song_title_url
    assert_response :success
  end

  test "should create song_title" do
    assert_difference("SongTitle.count") do
      post song_titles_url, params: { song_title: {  } }
    end

    assert_redirected_to song_title_url(SongTitle.last)
  end

  test "should show song_title" do
    get song_title_url(@song_title)
    assert_response :success
  end

  test "should get edit" do
    get edit_song_title_url(@song_title)
    assert_response :success
  end

  test "should update song_title" do
    patch song_title_url(@song_title), params: { song_title: {  } }
    assert_redirected_to song_title_url(@song_title)
  end

  test "should destroy song_title" do
    assert_difference("SongTitle.count", -1) do
      delete song_title_url(@song_title)
    end

    assert_redirected_to song_titles_url
  end
end
