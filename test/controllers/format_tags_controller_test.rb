require "test_helper"

class FormatTagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @format_tag = format_tags(:one)
  end

  test "should get index" do
    get format_tags_url
    assert_response :success
  end

  test "should get new" do
    get new_format_tag_url
    assert_response :success
  end

  test "should create format_tag" do
    assert_difference("FormatTag.count") do
      post format_tags_url, params: { format_tag: {  } }
    end

    assert_redirected_to format_tag_url(FormatTag.last)
  end

  test "should show format_tag" do
    get format_tag_url(@format_tag)
    assert_response :success
  end

  test "should get edit" do
    get edit_format_tag_url(@format_tag)
    assert_response :success
  end

  test "should update format_tag" do
    patch format_tag_url(@format_tag), params: { format_tag: {  } }
    assert_redirected_to format_tag_url(@format_tag)
  end

  test "should destroy format_tag" do
    assert_difference("FormatTag.count", -1) do
      delete format_tag_url(@format_tag)
    end

    assert_redirected_to format_tags_url
  end
end
