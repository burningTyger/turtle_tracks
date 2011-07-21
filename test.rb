require 'minitest/autorun'
require_relative 'logo'

class LogoTest < MiniTest::Unit::TestCase

  def test_factor_setter_ok
		l = Logo.new(5)
		l.factor=5
    assert_equal l.factor, 5
  end
  
  def test_factor_setter_zero
		l = Logo.new(5)
		l.factor=0
    assert_equal l.factor, 1
  end
end