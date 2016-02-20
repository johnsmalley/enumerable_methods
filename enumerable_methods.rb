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
		else				self.my_each do |element|
			count += 1 if arg == element
		end
		count
	end

	end


end