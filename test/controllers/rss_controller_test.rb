require 'test_helper'

class RssControllerTest < ActionController::TestCase
  test "should get extract" do
    get :extract
    assert_response :success
  end

end
