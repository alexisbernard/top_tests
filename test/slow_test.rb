# -*- encoding: utf-8 -*-

require 'minitest/autorun'
require 'top_tests'

class SlowTest < MiniTest::Unit::TestCase
  def test_good
    sleep(0.5)
  end

  def test_bad
    assert(true)
  end
end
