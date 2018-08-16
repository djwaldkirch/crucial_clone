require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  #this sets up an example user for the following tests
  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
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
    #sets email to 244As@example.com
    @user.email = "a" * 244 + "@example.com"
    #makes sure this e-mail is INVALID
    assert_not @user.valid?
  end
end
