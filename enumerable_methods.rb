module Enumerable
	def my_each
		return self.to_enum unless block_given?
		
		i = 0
		while i < self.size
			yield(self[i])
			i += 1
		end

		self
	end

	def my_each_with_index
		return self.to_enum unless block_given?
		
		i = 0
		while i < self.size
			yield(self[i], i)
			i += 1
		end

		self
	end

	def my_select
		return self.to_enum unless block_given?
		
		return_array = []
		
		self.my_each do |element|
			return_array << element if yield(element)
		end
		
		return_array
	end

	def my_all?
		status = true
		
		if block_given?
			self.my_each do |element|
				status = false unless yield(element)
			end
		else
			self.my_each do |element|
				status = false unless element
			end
		end

		status
	end

	def my_any?
		status = false
		
		if block_given?
			self.my_each do |element|
				status = true if yield(element)
			end
		else
			self.my_each do |element|
				status = true if element
			end
		end

		status
	end

	def my_none?
		status = true

		if block_given?
			self.my_each do |element|
				status = false if yield(element)
			end
		else
			self.my_each do |element|
				status = false if element
			end
		end

		status
	end

	def my_count(arg = (no_argument_passed = true; nil))
		count = 0
		if no_argument_passed
			count = self.length
		elsif block_given?
			self.my_each do |element|
				count += 1 if yield(element)
			end
		else				
			self.my_each do |element|
				count += 1 if arg == element
			end
		end

		count
	end

=begin
#This is the unmodify map method	
	def my_map
		return self.to_enum unless block_given?

		return_array = []

		self.my_each do |element|
			return_array << yield(element)
		end

		return_array
	end
=end

	def my_map(proc)
		#return self.to_enum unless block_given?

		return_array = []

		self.my_each do |element|
			if block_given?
				return_array << yield(proc.call(element))
			else
				return_array << proc.call(element)
			end
		end

		return_array
	end

	def my_inject(*args)
		array = self.to_a

		if args.length > 2
			raise ArgumentError.new("Wrong number of arguments: #{args.length} for 2")
		elsif args.length == 2
			initial = args.first
			sym = args.last
		elsif args.length == 1 && args.first.class == Symbol
			initial = nil
			sym = args.first
		elsif args.length == 1
			initial = args.first
			sym = nil
		else
			initial = nil
			sym = nil
		end

		if initial == nil
			memo = array.first
			steps = (1...array.length).to_a
		else
			memo = initial
			steps = (0...array.length).to_a
		end

		if sym == nil
			task = lambda { |memo, obj| yield(memo, obj) }
		else
			task = lambda { |memo, obj| memo.send(sym, obj) }
		end

		steps.my_each do |index|
			memo = task.call(memo, array[index])
		end

		return memo
	end

end

def multiply_els(array)
	array.my_inject(:*)
end