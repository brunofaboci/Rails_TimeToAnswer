require 'test_helper'

class AdminBackoffice::SubjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_backoffice_subjects_index_url
    assert_response :success
  end

end
