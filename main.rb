# to run
# % ruby main.rb [input_file output_file]
# if no argument is give the complex.logo file will be used
require_relative 'logo'
include Logo
input  = ARGV[0] || "complex.logo"
output = ARGV[1] || "complex_out.txt"
i = Interpreter.new
i.read(input)
result = i.run

o = Output.new
o.out(i.attr, result)
o.write(output)
