require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      name: "Johnny Boy", 
      email: "johnny@boy.com",
      password: "dale4life",
      password_confirmation: "dale4life"
    )
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@christmas.com"
    assert_not @user.valid?
  end

  test "email validation" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "should not allow multiple users with same email" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save

    assert_not duplicate_user.valid?
  end

  test "emails must be unique regardless of case" do
    mix_cased_email = "cOoLgUy@hotmail.com"
    @user.email = mix_cased_email
    @user.save
    assert_equal mix_cased_email.downcase, @user.reload.email
  end

  test "password should not be blank" do
    @user.password = "      "
    assert_not @user.valid?
  end

  test "password should be 6 or more characters" do
    @user.password = "12345"
    assert_not @user.valid?
  end

end
