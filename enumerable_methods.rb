module Enumerable
	def my_each
		i = 0
		while i < self.size
			yield(self[i])
			i += 1
		end
		self
	end

	def my_each_with_index
		i = 0
		while i < self.size
			yield(self[i], i)
			i += 1
		end
		self
	end

	def my_select
		return_array = []
		self.my_each do |element|
			return_array << element if yield(element)
		end
		return_array
	end

	def my_all?
		status = true
		self.my do |element|
			status = false if yield(element)
		end
		status
	end

end