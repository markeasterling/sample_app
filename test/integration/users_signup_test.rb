require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: {
        user: {
          name: " ",
          email: "invalid@invalid",
          password: "foo",
          password_confirmation: "baz"
        }
      }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information!" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: {
        user: {
          name: "dale",
          email: "dale@earnhardt.com",
          password: "fastestever",
          password_confirmation: "fastestever"
        }
      }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
