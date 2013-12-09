class Array

  def new_inject (*args, &block)
    raise 'wrong args' if args.length>1
    return self.first if self.length == 1 && args.empty?
    sum, operator = args, args.first
    sum_no_block = self.first
    self.each do |element|
      sum = yield(sum,element) if block_given?
      sum_no_block = sum_no_block.send(operator,element) unless block_given?
    end
    if block_given?
      sum.flatten
    else
      sum_no_block
    end
  end

end

class Array

  def rinject (sum=nil, &block)
    return sum if self.empty?
    sum ||= self.shift
    sum = yield(sum,self.shift)
    self.rinject(sum, &block)
  end

end

