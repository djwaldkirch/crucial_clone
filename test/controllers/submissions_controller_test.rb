require 'test_helper'

class SubmissionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @submission = submissions(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Submission.count' do
      post submissions_path, params: { submission: { title: "Master of Puppets", artist: "Metallica", genre: "Metal", lyrics: "Master! Master!" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Submission.count' do
      delete submission_path(@submission)
    end
    assert_redirected_to login_url
  end
end