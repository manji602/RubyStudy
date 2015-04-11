puts "hello,ruby"

###########
# variables
###########

# variables
## local variable begin from '_'
_localVaiable = 1
puts _localVaiable

## instance variable begin from '@'
@instanceVariable = 2
puts @instanceVariable

## class variable begin from '@@'
@@classVariable = 3
puts @@classVariable

## global variable begin from '$'
$globalVariable = 4
puts $globalVariable

## constants variable are large capitals
CONSTANT_VARIABLE = 5
puts CONSTANT_VARIABLE

###########
# array
###########

_arraySample = [ "a", "b", "c", "d" ]
puts _arraySample[0]
_arraySample[4] = "e"
puts _arraySample[4]
puts _arraySample.size

_arraySample.each do |element|
  puts element
end

_arraySample.each_with_index do |element, index|
  _format = element + " " + index.to_s
  puts _format
end

_arraySample2 = 1..20

_arraySample2.each do |element|
  if element > 10 then
    puts element
  else
    puts "OK"
  end
end

###########
# hash
###########

_hashSample = { 1 => 2, 3 => 4, 5 => 6 }
puts _hashSample[3]

_hashSample.each do |key, value|
  puts key.to_s + " " + value.to_s
end

# :a : symbol
_hashSample2 = { :a => "A", :b => "B", :c => "C" }
puts _hashSample2[:a]

_hashSample3 = { a:"A", b:"B", c:"C" }
puts _hashSample3[:a]

###########
# function
###########

def sample
  puts "hello!"
end

sample()

###########
# condition
###########

_condition_sample = 1..20

_condition_sample.each do |element|
  case _condition_sample
  when 1
    puts "1!!!"
  else
    puts "OTHER"
  end

end

_counter = 0

loop do
  _counter = _counter + 1
  puts _counter
  if _counter > 10
    break
  end
end
