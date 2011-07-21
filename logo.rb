class Logo
	attr_reader :factor
	
	def initialize(canvas)
		canvas_size = canvas.to_i
		o = canvas_size.div(2)
		@pos = [o,o]
		@canvas[@pos] = true
		@dir = [[0,-1], [1,0], [0,-1], [-1,0]]
		@factor = 1
	end
	
	def factor=(n)
		n = 1 if n == 0
		@factor = n
	end
	
	def fd(n)
		n.times do
			@pos = 
		end
	end
	
	def rt(n)
		raise unless n.modulo(45)
		turns = n.to_f/90
		rotate = turns.to_i
		@factor = turns-rotate
		@dir.cycle(rotate)
	end
	
	def lt(n)
	
	end
	
	def bk(n)
	
	end
	
	def repeat(n)
	
	end
end