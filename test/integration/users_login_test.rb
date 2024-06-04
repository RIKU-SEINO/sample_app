require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  test "login with valid information" do
    post login_path, params: { session: }

  end
end
