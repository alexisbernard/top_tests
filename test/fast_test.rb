# -*- encoding: utf-8 -*-

require 'minitest/autorun'
require 'top_tests'

class FastTest < MiniTest::Unit::TestCase
  def test_good
    sleep(0.499)
  end
end
