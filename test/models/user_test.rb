require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Expample', email: 'user@example.com', password: 'foobar', password_confirmation: 'foobar')
  end
  test 'should be valid' do
    assert @user.valid?
  end
  test 'name should be present' do
    @user.name = '  '
    assert_not @user.valid?
  end
  test 'email should be present' do
    @user.email = '      '
    assert_not @user.valid?
  end
  test 'name should not be too long' do
    @user.name = 'a' * 31
    assert_not @user.valid?
  end
  test 'email should not be too long' do
    @user.email = 'a' * 31
    assert_not @user.valid?
  end
  test 'email validation should accept valid address' do
    valid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert_not @user.valid?, "#{valid_address.inspect} should be invalid"
    end
  end
  test 'email addresses should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
  test 'password should be present (nonblank)' do
    @user.password = @user.password_confirmation = ' ' * 2
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 2
    assert_not @user.valid?
  end
end
