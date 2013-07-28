require 'test_helper'

class SendingControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get :index, id: @line_item
    assert_response :success
  end

  test "should get sendout" do
    get :sendout, id: @line_item
    assert_redirected_to orders_path
  end

  test "should get stockout" do
    get :stockout, id: @line_item
    assert_redirected_to orders_path
  end

end
