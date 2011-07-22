require 'minitest/autorun'
require_relative 'logo'

include Logo

class CommandsTest < MiniTest::Unit::TestCase
	def setup
		@l = Commands.new(5)
	end
	
  def test_canvas_set
    assert_equal @l.pos, [2,2]
  end
  
  def test_rt
  	@l.rt(90)
    assert_equal @l.direction[0], [1,0]
  end

  def test_lt
  	@l.lt(90)
    assert_equal @l.direction[0], [-1,0]
  end

  def test_fd
  	@l.fd(2)
    assert_equal @l.pos, [2,0]
  end

  def test_bk
  	dir = @l.direction.dup
  	@l.bk(2)
    assert_equal @l.pos, [2,4]
    assert_equal @l.direction, dir
  end

  def test_repeat
  	@l.repeat(2, ["lt 90", "fd 2"])
    assert_equal @l.pos, [0,4]
  end
  
  def test_rt_fd
  	@l.bk(2) #3,5
  	@l.rt(45)
  	@l.fd(1) #4,4
  	@l.lt(90)
  	@l.fd(2) #2,2
    assert_equal @l.pos, [1,1]
  end
  
  def test_canvas
  	@l.bk(2) #2
  	@l.rt(45)
  	@l.fd(1) #3
  	@l.lt(90)
  	@l.fd(2) #5
    assert_equal @l.canvas.keys, [[2,2], [2,3], [2,4], [3,3], [1,1]]
  end
end

class InterpreterTest < MiniTest::Unit::TestCase
	def setup
		@i = Interpreter.new
	end
	
	def test_read
		@i.read("simple.logo")
		assert_equal @i.attr, 61
		assert_equal @i.prog.size, 7
		assert_equal @i.prog[0], "rt 135"
		assert_equal @i.prog[2], "repeat 2, [ 'rt 90', 'fd 15' ]"
	end
	
	def test_run
		@i.read("simple.logo")
		@i.run
	end
end
