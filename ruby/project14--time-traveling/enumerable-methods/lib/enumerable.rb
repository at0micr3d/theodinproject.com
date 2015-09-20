require 'pry'

module Enumerable
	def my_each
		for i in 0..self.length - 1
			yield self[i]
		end
		self
	end

	def my_each_with_index
		for i in 0..self.length - 1
			yield self[i], i
		end
		self	
	end

	def my_select
		ret = []
		self.my_each_with_index {|it, ind| ret << it if yield self[ind]}
		ret
	end

	def my_all?
		if block_given?
			ret = []
			self.my_each_with_index {|it, ind| ret << it if yield self[ind]}
			return ret.length.to_i == self.length.to_i
		end
		return self.my_select {|i| (i != false || i != nil) }.length == self.length
	end

	def my_any?
		ret = []
		self.my_each_with_index {|it, ind| ret << it if yield self[ind]}
		ret.length > 0
	end

	def my_none?
		ret = []
		self.my_each_with_index {|it, ind| ret << it if yield self[ind]}
		ret.length == 0
	end

	def my_count(opt = false)
		return self.my_select {|i| i == opt}.length if opt != false #only nil and false return false. 
		return self.length if not block_given?
		ret = []
		self.my_each_with_index {|it, ind| ret << it if yield self[ind]}
		return ret.length
	end

	def my_map()
		ret = []
		self.my_each {|i| ret << yield(i)}
		return ret
	end

	def my_map_proc(proc)
		ret = []
		self.my_each {|i| ret << proc.call(i)}
		return ret
	end
	
	def my_map_proc_or_block(block, proc = false)
		ret = []
		for i in 0..self.length
			ret << block.call(proc.call(i)) if proc and block_given?
			ret << proc.call(i) if proc and !block_given?
			ret << yield(i) if !proc and block_given?
		end
		ret
	end

	def my_inject(tot = 0)
		for i in 0..self.length - 1
			tot = yield tot, self[i]
		end
		tot
	end
end










