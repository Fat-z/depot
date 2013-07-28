require 'test_helper'

class CommentLineItemsControllerTest < ActionController::TestCase
  setup do
    @comment_line_item = comment_line_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comment_line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comment_line_item" do
    assert_difference('CommentLineItem.count') do
      post :create, comment_line_item: { comment_content: @comment_line_item.comment_content, comment_id: @comment_line_item.comment_id, product_id: @comment_line_item.product_id }
    end
   assert_redirected_to product_path(@comment_line_item.product_id)
  end

  test "should show comment_line_item" do
    get :show, id: @comment_line_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comment_line_item
    assert_response :success
  end

  test "should update comment_line_item" do
    put :update, id: @comment_line_item, comment_line_item: { comment_content: @comment_line_item.comment_content, comment_id: @comment_line_item.comment_id, product_id: @comment_line_item.product_id }
    assert_redirected_to comment_line_item_path(assigns(:comment_line_item))
  end

  test "should destroy comment_line_item" do
    assert_difference('CommentLineItem.count', -1) do
      delete :destroy, id: @comment_line_item
    end

    assert_redirected_to comment_line_items_path
  end
end
