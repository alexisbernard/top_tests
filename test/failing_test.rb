# -*- encoding: utf-8 -*-

require 'minitest/autorun'
require 'top_tests'

class FailingTest < MiniTest::Unit::TestCase
  def test_bad
    assert(false)
  end
end
