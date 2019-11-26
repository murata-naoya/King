require 'test_helper'

class Admin::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_reviews_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_reviews_edit_url
    assert_response :success
  end

  test "should get _index" do
    get admin_reviews__index_url
    assert_response :success
  end

end
