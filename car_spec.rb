# So far we have only used the asserion or assert-style syntax. Minitest also has a completely different syntax
# called expectation or spec-style syntax. 
# In expectation style syntax, tests are grouped into 'describe' blocks, and individual tests are written with the 'it' method.
# We no longer use assertions, and instead use expectation matchers. 

require 'minitest/autorun'

require_relative 'car'

describe 'Car#wheels' do
	it 'has 4 wheels' do 
		car = Car.new
		car.wheels.must_equal 4 # this is the expectation
	end
end