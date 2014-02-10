require 'test_helper'

class MapControllerTest < ActionController::TestCase
  test "should get tweets" do
    get :tweets
    assert_response :success
  end

end
