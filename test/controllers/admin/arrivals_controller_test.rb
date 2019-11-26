require 'test_helper'

class Admin::ArrivalsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_arrivals_new_url
    assert_response :success
  end

end
