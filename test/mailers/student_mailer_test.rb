require 'test_helper'

class StudentMailerTest < ActionMailer::TestCase
  test "info_status" do
    mail = StudentMailer.info_status
    assert_equal "Info status", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "account_activation" do
    mail = StudentMailer.account_activation
    assert_equal "Account activation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
