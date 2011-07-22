module Logo
	
	class Commands
		
		attr_reader :pos, :canvas, :direction, :canvas_size
		def initialize(canvas)
			@canvas_size = canvas
			o = @canvas_size.div(2)
			@pos = [o,o]
			@canvas = {}
			@direction = [[0,-1], [1,-1], [1,0], [1,1], [0,1], [-1,1], [-1,0], [-1,-1]]
			canvas_set		
		end
		
		def call(c)
			eval(c)
		end
		
		def canvas_set
			@canvas[@pos.dup] = true
		end
		
		def turns(n)
			raise unless n.modulo(45) == 0
			turns = n/45
		end
		
		private :canvas_set, :turns
		
		def fd(n)
			n.times do
				@pos[0] += @direction[0][0]
				@pos[1] += @direction[0][1]
				raise if @pos[0] > @canvas_size or @pos[1] > @canvas_size
				canvas_set
			end
		end
		
		def rt(n)
			@direction.push(*@direction.shift(turns(n)))
		end
		
		def lt(n)
			@direction.unshift(*@direction.pop(turns(n)))
		end
		
		def bk(n)
			rt(180)
			fd(n)
			lt(180)
		end
		
		def repeat(n, commands)
		  commands.cycle(n) { |c| eval(c) }
		end
	end
	
	class Interpreter
		
		attr_reader :prog, :attr
		def initialize
			@prog = []
			@attr = ""
		end
		
		def read(file)
			File.open(file, 'r') do |f|
				@attr = f.readline.to_i
				f.each_line do |l|
					l.strip!
					next if l.empty?
					l.downcase!
					if l.start_with?("repeat")
						l.sub!(/\d/, '\0,')
						sub_str = l.scan(/\[ (.*?) \]/).join
						sub_ary = sub_str.split
						sub_ary = sub_ary.each_slice(2).map { |c| "'"+c.join(" ")+"'" } 
						l.gsub!(sub_str, sub_ary.join(", "))
						@prog << l
					else
						@prog << l
					end
				end
			end
		end
		
		def run
			app = Commands.new(@attr)
			@prog.each {|c| app.call(c) }
			app.canvas
		end
	end	

	class Output
		
		def initialize
			@str = ""
		end
	
		def write(file)
			File.open(file, 'w') {|f| f.write(@str) }
		end
		
		def out(size, positions)
			size.times do |y|
				size.times do |x|
					if positions[[x,y]]
						@str << "X "
					else
						@str << ". "
					end
				end
				@str.rstrip! << "\n"
			end
		end
	end
end
