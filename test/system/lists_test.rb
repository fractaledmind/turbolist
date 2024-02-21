require "application_system_test_case"

class ListsTest < ApplicationSystemTestCase
  setup do
    @list = lists(:one)
  end

  test "visiting the index" do
    visit lists_url
    assert_selector "h1", text: "Lists"
  end

  test "should create list" do
    skip "Not implemented yet"

    visit lists_url
    click_on "New list"

    fill_in "Title", with: @list.title
    send_keys "submit"

    assert_selector "input[value=#{@list.title}]"
  end

  test "should update List" do
    skip "Not implemented yet"

    visit list_url(@list)

    fill_in "Title", with: @list.title
    click_on "Update List"

    assert_text "List was successfully updated"
    click_on "Back"
  end

  test "should destroy List" do
    skip "Not implemented yet"

    visit list_url(@list)
    click_on "Delete list", match: :first

    assert_text "List was successfully destroyed"
  end
end
