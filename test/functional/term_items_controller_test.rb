require 'test_helper'

class TermItemsControllerTest < ActionController::TestCase
  setup do
    @term_item = term_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:term_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create term_item" do
    assert_difference('TermItem.count') do
      post :create, term_item: { dataset_id: @term_item.dataset_id, term_id: @term_item.term_id }
    end

    assert_redirected_to term_item_path(assigns(:term_item))
  end

  test "should show term_item" do
    get :show, id: @term_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @term_item
    assert_response :success
  end

  test "should update term_item" do
    put :update, id: @term_item, term_item: { dataset_id: @term_item.dataset_id, term_id: @term_item.term_id }
    assert_redirected_to term_item_path(assigns(:term_item))
  end

  test "should destroy term_item" do
    assert_difference('TermItem.count', -1) do
      delete :destroy, id: @term_item
    end

    assert_redirected_to term_items_path
  end
end
