require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  #this sets up an example user for the following tests
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
  end
  
  #name of the test, start block
  test "should be valid" do
    #is the user valid? validity depends on whatever validations we put in the user model
    #if it is valid, this test returns true/successful
    assert @user.valid?
  end

  
  test "name should be present" do
    #this changes the name of the example user to a bunch of spaces
    @user.name = "     "
    #this returns true if the name is INVALID. We want spaces to be invalid in order to pass
    assert_not @user.valid?
  end
  
  #exact same thing as above, but with email
  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  #this test makes sure the name is not too long
  test "name should not be too long" do
    #this sets the name to 51 As in a row
    @user.name = "a" * 51
    #this makes sure that 51 As is an INVALID name. We want it to be invalid to pass the test
    assert_not @user.valid?
  end

  #same thing but with email. Only the length limit is a lot longer (244 instead of 51)
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  #sets a list of email addresses with quirks, loops through them and checks for validity, returns confirmation message
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  #same thing as above, but uses invalid email addresses and asserts that they are invalid
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  #duplicates the example user, tries to save it. runs into validator in model and fails. checks for failure
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  #same as name and email stuff above
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "associated submissions should be destroyed" do
    @user.save
    @user.submissions.create!(title: "Reign in Blood", artist: "Slayer", genre: "Metal", lyrics: "Dun dun Dun")
    assert_difference 'Submission.count', -1 do
      @user.destroy
    end
  end
end
