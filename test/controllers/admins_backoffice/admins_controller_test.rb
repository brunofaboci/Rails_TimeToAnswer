require 'test_helper'

class AdminsBackoffice::AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_backoffice_admins_index_url
    assert_response :success
  end

end
