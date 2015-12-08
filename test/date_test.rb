require File.expand_path("../test_helper", __FILE__)

class SabreDevStudio::Helpers::DateExtensionTests < Minitest::Test
  def test_make_date
    str = "2013-01-21"
    date = SabreDevStudio::Helpers::DateExtensions.make_date(str)
    assert_equal str, date.to_s
    assert_equal 2013, date.year
  end
  def test_make_date_time
    str = "2013-01-21T17:00:00"
    gmt_offset = -5
    datetime = SabreDevStudio::Helpers::DateExtensions.make_time(str, gmt_offset)
    assert_equal 2013, datetime.year
    assert_equal "-05:00", datetime.strftime("%Z")
  end
end
