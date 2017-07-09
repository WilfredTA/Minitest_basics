# Write our own method that mimics Integer#times...

# Step 1: What does Integer#times do
	#5.times do |num|
	#	puts num
#	end 
	# 0
	# 1
	# 2
	# 3
	# 4
	# => 5
# Notice that the method's first block argument is 0 and it's last block argument
# is one less than the calling object. Finally, the method returns the calling object

# We don't have a calling object, but we do have a method argument, so we will return that instead: 

# times(5) do |num|
	# puts num
# end

# should mimic the above Integer#times method


def times(number)
	counter = 0
	while counter < number do
		yield(counter)
		counter += 1
	end
	number
end


5.times do 
	p [1,2,3].sample
end

# The above code produces same output as Integer#times