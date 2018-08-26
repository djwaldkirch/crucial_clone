require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    # This code is not idiomatically correct.
    @submission = @user.submissions.build(title: "Purple Haze", artist: "Jimi Hendrix", genre: "rock", lyrics: "Purple Haze all through my brain.", user_id: @user.id)
  end

  test "should be valid" do
    assert @submission.valid?
  end

  test "user id should be present" do
    @submission.user_id = nil
    assert_not @submission.valid?
  end
  
  test "all fields should have something" do
    @submission.title = "   "
    assert_not @submission.valid?
    @submission.artist = "   "
    assert_not @submission.valid?
    @submission.genre = "   "
    assert_not @submission.valid?
    @submission.lyrics = "   "
    assert_not @submission.valid?
  end

  test "content should be at most 140 characters" do
    @submission.title = "a" * 101
    assert_not @submission.valid?
    @submission.artist = "a" * 101
    assert_not @submission.valid?
    @submission.genre = "a" * 101
    assert_not @submission.valid?
  end
  
  test "order should be most recent first" do
    assert_equal submissions(:most_recent), Submission.first
  end
  
  
end