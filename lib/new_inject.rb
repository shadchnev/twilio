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

p [1,2,3].new_inject(:*)

class Array

  def recursive_inject (*args, &block)
    sum = args
    raise 'wrong args' if args.length>1
    return self.first if self.length == 1 && args.empty?
    return self.first if self.length == 1
    sum += yield(sum, recursive_inject(self.pop) {block})
  end

end

[1,2,3].recursive_inject(0) { |a,b| a << b }