require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @task = tasks(:one)
  end

  test "visiting the index" do
    visit tasks_url
    assert_selector "h1", text: "Inbox"
  end

  test "should create task" do
    visit tasks_url

    fill_in "New task", with: @task.title, match: :first

    send_keys "submit"

    assert_selector "h1", text: "Inbox"
    assert_selector "input[value=#{@task.title}]"
  end

  test "should update Task" do
    skip "Not implemented yet"

    visit task_url(@task)
    click_on "Edit this task", match: :first

    fill_in "Title", with: @task.title
    click_on "Update Task"

    assert_text "Task was successfully updated"
    click_on "Back"
  end

  test "should destroy Task" do
    skip "Not implemented yet"

    visit task_url(@task)
    click_on "Destroy this task", match: :first

    assert_text "Task was successfully destroyed"
  end
end
