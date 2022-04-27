require "test_helper"

class Admin::GeneralTransactionsLinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_general_transactions_lines_index_url
    assert_response :success
  end

  test "should get create" do
    get admin_general_transactions_lines_create_url
    assert_response :success
  end

  test "should get new" do
    get admin_general_transactions_lines_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_general_transactions_lines_edit_url
    assert_response :success
  end

  test "should get show" do
    get admin_general_transactions_lines_show_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_general_transactions_lines_destroy_url
    assert_response :success
  end
end
