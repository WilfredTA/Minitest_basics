def select(array)
	new_array = []
	counter = 0
	while counter < array.size
		if yield(array[counter])
			new_array << array[counter]
		end
		counter += 1
	end
	new_array
end


p [1,2,3].select { |num| num.odd?}

p select([1,2,3]) { |num| num.odd?}