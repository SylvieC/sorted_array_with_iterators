class SortedArray
  attr_reader :internal_arr

  def initialize arr=[]
    @internal_arr = []
    arr.each { |el| add el }
  end

  def add el
    # we are going to keep this array
    # sorted at all times. so this is ez
    lo = 0
    hi = @internal_arr.size
    # note that when the array just
    # starts out, it's zero size, so
    # we don't do anything in the while
    # otherwise this loop determines
    # the position in the array, *before*
    # which to insert our element
    while lo < hi
      # let's get the midpoint
      mid = (lo + hi) / 2
      if @internal_arr[mid] < el
        # if the middle element is less 
        # than the current element
        # let's increment the lo by one
        # from the current midway point
        lo = mid + 1
      else
        # otherwise the hi *is* the midway 
        # point, we'll take the left side next
        hi = mid 
      end
    end

    # insert at the lo position
    @internal_arr.insert(lo, el)
  end

  def each &block
    i = 0
    while i < @internal_arr.size
      yield  @internal_arr[i]
      i += 1
    end
    return @internal_arr
  end

  def map &block
    i = 0
    while i < @internal_arr.size
      yield @internal_arr[i]
      i += 1
    end
    return @internal_arr
  end

  def map! &block
    i = 0
    new_array = []
    while i < @internal_arr.size
       new_array.push(yield @internal_arr[i])
      i += 1
    end
    return new_array
  end

  def find(value)
    #find index of the first occurence for which the block returns true
    #find(ifnone = nil) { |obj| block } → obj or nil clic for which |i, value|
    i = 0
    while i < @internal_arr.size
      if yield(@internal_arr[i])
        return @internal_arr[i]
      else
      i += 1
      end
    end
    return value
  end

  def inject acc=nil, &block
   # acc = nil
   #  @internal_arr.each { |value| acc = yield(acc, value)}
   #  return acc

    if acc ==nil
      acc = @internal_arr[0]
      i = 1
    else
     i = 0
    end
    
    while i < @internal_arr.size
      acc = yield(acc, @internal_arr[i])
      i+= 1
    end
   return acc
  end 
   
  end
