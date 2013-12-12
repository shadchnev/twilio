class Array

  # This implementation seems to work but it's way more complex that it should have been  
  def new_inject (*args, &block)
    raise 'wrong args' if args.length>1
    return self.first if self.length == 1 && args.empty?
    sum, operator = args, args.first
    sum_no_block = self.first
    self.each do |element|
      # these two conditions are a simple if/else statement.
      # why didn't you use it?
      sum = yield(sum,element) if block_given?
      # at first, sum_no_block is initialised with self.first
      # and then you're calling .send on it?
      sum_no_block = sum_no_block.send(operator,element) unless block_given?
    end
    if block_given?
      sum.flatten
    else
      sum_no_block
    end
  end

  # what about this?
  def new_inject(initial = nil)    
    result = initial || first
    tail = initial ? self : slice(1..-1)
    tail.each do |element|
      result = yield result, element
    end
    result
  end

end

class Array

  # well done for the recursive implementation!s
  def rinject (sum=nil, &block)
    return sum if self.empty?
    # this modifies the original array
    # You should have created a copy
    sum ||= self.shift
    sum = yield(sum,self.shift)
    self.rinject(sum, &block)
  end

end

