# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
module MyEnumerable
  def my_each(&block)
    @list.each(&block)
  end

  def all?(params = nil)
    my_each do |item|
      if block_given?
        return false unless yield item
      elsif params.is_a?(Class)
        return false unless item.is_a?(params)
      elsif params.is_a?(Regexp)
        return false unless params.match(item)
      else
        return false unless item == params
      end
    end
    true
  end

  def any?(params = nil)
    my_each do |item|
      if params.is_a?(Class)
        return true if item.is_a?(params)
      elsif params.is_a?(Regexp)
        return true if params.match(item)
      elsif block_given?
        return true if yield item
      elsif item == params
        return true
      end
    end
    false
  end

  def filter(params = nil)
    result = []
    my_each do |item|
      if params.is_a?(Class)
        result << item if item.is_a?(params)
      elsif params.is_a?(Regexp)
        result << item if params.match(item)
      elsif block_given?
        result << item if yield item
      elsif item == params
        result << item
      end
    end
    result
  end

  def min
    c = @list[0].class
    my_each do |item|
      return p 'Cannot compare String and Integer' unless item.instance_of?(c)
    end
    @list.min
  end

  def max
    c = @list[0].class
    my_each do |item|
      return unless item.instance_of?(c)
    end
    @list.max
  end
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
