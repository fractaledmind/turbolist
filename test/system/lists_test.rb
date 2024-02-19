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
    visit lists_url
    click_on "New list"

    fill_in "Title", with: @list.title
    click_on "Create List"

    assert_text "List was successfully created"
    click_on "Back"
  end

  test "should update List" do
    visit list_url(@list)
    click_on "Edit this list", match: :first

    fill_in "Title", with: @list.title
    click_on "Update List"

    assert_text "List was successfully updated"
    click_on "Back"
  end

  test "should destroy List" do
    visit list_url(@list)
    click_on "Destroy this list", match: :first

    assert_text "List was successfully destroyed"
  end
end
