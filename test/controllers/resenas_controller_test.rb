require 'test_helper'

class ResenasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get resenas_index_url
    assert_response :success
  end

  test "should get show" do
    get resenas_show_url
    assert_response :success
  end

  test "should get edit" do
    get resenas_edit_url
    assert_response :success
  end

end
