# Takes an array as argument
# Takes an optional second arg
# Iterates over array, passing accumulator and current el to block
# Sets accumulator to return value of block


def reduce(array, beginning_value = 0)

	counter = 0
	accumulator = beginning_value

	while counter < array.size
		accumulator = yield(accumulator, array[counter])
		counter += 1
	end

	accumulator
end