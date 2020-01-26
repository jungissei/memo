require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
  end

  test "visiting the index" do
    visit posts_url
    assert_selector "h1", text: "Posts"
  end

  test "creating a Post" do
    visit posts_url
    click_on "New Post"

    fill_in "Answer", with: @post.answer
    fill_in "Before answer", with: @post.before_answer
    fill_in "Next time", with: @post.next_time
    fill_in "Num anser", with: @post.num_anser
    fill_in "Num correct", with: @post.num_correct
    fill_in "Question", with: @post.question
    fill_in "User", with: @post.user_id
    click_on "Create Post"

    assert_text "Post was successfully created"
    click_on "Back"
  end

  test "updating a Post" do
    visit posts_url
    click_on "Edit", match: :first

    fill_in "Answer", with: @post.answer
    fill_in "Before answer", with: @post.before_answer
    fill_in "Next time", with: @post.next_time
    fill_in "Num anser", with: @post.num_anser
    fill_in "Num correct", with: @post.num_correct
    fill_in "Question", with: @post.question
    fill_in "User", with: @post.user_id
    click_on "Update Post"

    assert_text "Post was successfully updated"
    click_on "Back"
  end

  test "destroying a Post" do
    visit posts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Post was successfully destroyed"
  end
end
