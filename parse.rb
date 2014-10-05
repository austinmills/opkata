$: << File.join(File.dirname(__FILE__), '.', 'lib')
require 'digit_parser'

def usage_and_exit
  puts "Usage: parse.rb <filename>"
  exit(1)
end

filename = ARGV[0] || usage_and_exit

text = File.read(filename)

parser = DigitParser.new

results = parser.parse(text)
results.each {|r| puts r }




