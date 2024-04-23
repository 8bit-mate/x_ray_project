require "application_system_test_case"

class FormatTagsTest < ApplicationSystemTestCase
  setup do
    @format_tag = format_tags(:one)
  end

  test "visiting the index" do
    visit format_tags_url
    assert_selector "h1", text: "Format tags"
  end

  test "should create format tag" do
    visit format_tags_url
    click_on "New format tag"

    click_on "Create Format tag"

    assert_text "Format tag was successfully created"
    click_on "Back"
  end

  test "should update Format tag" do
    visit format_tag_url(@format_tag)
    click_on "Edit this format tag", match: :first

    click_on "Update Format tag"

    assert_text "Format tag was successfully updated"
    click_on "Back"
  end

  test "should destroy Format tag" do
    visit format_tag_url(@format_tag)
    click_on "Destroy this format tag", match: :first

    assert_text "Format tag was successfully destroyed"
  end
end
