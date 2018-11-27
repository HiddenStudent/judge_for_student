require 'test_helper'

class AtaskControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get atask_new_url
    assert_response :success
  end

  test "should get edit" do
    get atask_edit_url
    assert_response :success
  end

end
