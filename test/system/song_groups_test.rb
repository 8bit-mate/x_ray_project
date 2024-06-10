require "application_system_test_case"

class SongGroupsTest < ApplicationSystemTestCase
  setup do
    @song_group = song_groups(:one)
  end

  test "visiting the index" do
    visit song_groups_url
    assert_selector "h1", text: "Song titles"
  end

  test "should create song title" do
    visit song_groups_url
    click_on "New song title"

    click_on "Create Song title"

    assert_text "Song title was successfully created"
    click_on "Back"
  end

  test "should update Song title" do
    visit song_group_url(@song_group)
    click_on "Edit this song title", match: :first

    click_on "Update Song title"

    assert_text "Song title was successfully updated"
    click_on "Back"
  end

  test "should destroy Song title" do
    visit song_group_url(@song_group)
    click_on "Destroy this song title", match: :first

    assert_text "Song title was successfully destroyed"
  end
end
