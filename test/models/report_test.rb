# == Schema Information
#
# Table name: reports
#
#  id         :bigint           not null, primary key
#  body       :string
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :string
#
require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test "report cannot be empty" do
    reports.each do |report|
        body = report.body
        report.body = ""
        assert_not report.valid?

        report.body = body
        report.body = nil
        assert_not report.valid?
    end
end
test "report's user_id cannot be empty" do
    reports.each do |report|
        user = report.user_id
        report.user_id = ""
        assert_not report.valid?

        report.user_id = user
        report.user_id = nil
        assert_not report.valid?
    end
end
end
