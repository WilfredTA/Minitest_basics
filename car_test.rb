require 'minitest/autorun' # This loads all the necessary files from the minitest gem
require 'minitest/reporters'
Minitest::Reporters.use!


require_relative 'car' # This requires the file we are testing: car.rb, which contains the Car class
						# we use 'require_relative' to specify the file name from the current file's directory.
						# Now when we reference the Car class, Ruby knows where to look for it

#class CarTest < MiniTest::Test  # Our test class subclasses the MiniTest::Test class. 
#	def test_wheels
#		car = Car.new
#		assert_equal(4, car.wheels)
#	end
#
#	def test_bad_wheels
#		skip
#		car = Car.new
#		assert_equal(3, car.wheels)
#	end
#end

# Within test class, we can write tests by creating instance methods that start with 'test_' Through this naming convention
# Minitest will know what these methods are individual tests that need to be run. Within each test 
# (or instance method that starts with 'test_') we will need to make some assertions.
# These assertions are what we are trying to verify. Before we make any assertions, we have to first setup the appropriate
# data or objects to make assertions against. For example, on line 9, we first instatiate a Car object. We then use
# this Car object in our assertion to verify that newly created car objects indeed have 4 wheels.

# assert_equal is an inherited instance method from somewhere up the hierarchy. assert_equal takes two parameters: The first
# is the expected value, and the second is the test or actual value. If there's a discrepancy, assert_equal will save the error and
# Minitest will report that error at the end of test run.

# Assert_equal is testing value equality, not object equality. We are invoking the '==' method on the object. If we are looking
# for object equality, we have to use the assert_same assertion.

class CarTest < MiniTest::Test

	def setup
		@car = Car.new
	end

  def test_car_exists
    assert(c@ar)
  end

  def test_wheels
    assert_equal(4, @car.wheels)
  end

  def test_name_is_nil
    assert_nil(@car.name)
  end

  def test_raise_initialize_with_arg
    assert_raises(ArgumentError) do
      car = Car.new(name: "Joey")
    end
  end

  def assert_instance_of_car
    assert_instance_of(Car, @car)
  end

  def test_includes_car
    arr = [1, 2, 3]
    arr << @car

    assert_includes(arr, @car)
  end
end