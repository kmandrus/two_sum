#Given an array of unique integers and a target sum, determine whether any 
#two integers in the array sum to that amount.
def two_sum?(arr, target_sum)
    # your code here...
end

arr = [0, 1, 5, 7]

    #Speculation on possible implementations...
#Finding all possible sums and searching them is O(n^2). Space complexity is
#also O(n^2)

    #Brute force
#Finding the largest and smallest numbers as bounds would be linear time. Using
#those to discard certain numbers would speed up the process, but worse case is
#still quadratic time. Space complexity suffers from similar difficulties.

    #Sorting
#Sorting can happen in O(nlogn). For a given number, we can then compute exactly
#what other number must be in the array to create the sum. We can find if that
#number is in the array with a binary search, which takes O(log n) time.
#Finally, looping through the array takes O(n) time. In theory, we would have:
# nlog(n) + n * log(n) = 2nlog(n) = O(nlogn)
#Space complexity is O(n) because we need to store the sorted array.

    #Hashing
#Is it possible to do better? If a solution in linear time exists, it cannot
#rely on sorting algorithms, nor can it use the binary search within a loop.
#Can hashing do something for us? What should we hash? Hashing every sum would
#put us at quadratic time again, so that's out. Hashing num => index
#(essentially inverting the array's structure) would take linear time. We could
#lookup if any number is present in the array in constant time! We could then
#loop over the array in linear time, and see if what we need to make the sum is
#present in constant time! This gives us a rather simple to implement O(n) time
#solution. Storing the hash would also make for linear space complexity,
#which is nice.

    #Is there no better solution?
#A solution that involves log n time... would need a sorted array of elements
#that only needed to be searched once, if it relies on binary search. Since we
#have an unsorted array as a parameter, that's out. At this point, I don't know
#of any other algorithms that run in log(n) time. I'm unsure of how to proceed
#without being struck by great revelation.

#Time: O(n^2)
#Space: O(1)
def brute_force_two_sum?(arr, target_sum)
    arr.each_with_index do |num_1, i_1|
        (i_1 + 1...arr.length).each do |i_2|
            num_2 = arr[i_2]
            return true if num_1 + num_2 == target_sum
        end
    end
    false
end

p "brute force two sum"
p brute_force_two_sum?(arr, 6) # => should be true
p brute_force_two_sum?(arr, 10) # => should be false

def binary_search(arr, target)
    mid = (arr.length - 1) / 2
    return false if mid == 0
    mid_el = arr[mid]
    return true if mid_el == target
    if mid_el > target 
        binary_search(arr[0...mid], target)
    else
        binary_search(arr[mid+1..-1], target)
    end
end

#Time: O(nlog n)
#Space: O(n)
def sorting_two_sum?(arr, target_sum)
    sorted = arr.sort
    sorted.each do |num|
        target = target_sum - num
        return true if binary_search(sorted, target)
    end
    false
end

p "Sorting two_sum"
p sorting_two_sum?(arr, 6) # => should be true
p sorting_two_sum?(arr, 10) # => should be false

#Time: O(n)
#Space: O(n)
def hashing_two_sum?(arr, target_sum)
    count = Hash.new(false)
    arr.each { |num| count[num] = true } 
    arr.each do |num|
        target_num = target_sum - num
        unless target_num == num
            return true if count[target_num]
        end
    end
    false
end

p "Hashing implementation"
p hashing_two_sum?(arr, 6) # => should be true
p hashing_two_sum?(arr, 10) # => should be false

#Time:
#Space:
def two_sum_helper(arr, target_sum)
    count = Hash.new(false)
    arr.each { |num| count[num] = true } 
    arr.each do |num|
        target_num = target_sum - num
        unless target_num == num
            return [num, target_num] if count[target_num]
        end
    end
    nil
end

#finds the smallest sum in the array 
def min_two_sum(arr)
    ints = arr.dup
    min_1 = ints.min
    ints.delete(min_1)
    min_2 = ints.min
    min_1 + min_2
end
#An implementation of two sum that returns the integers
p "two_sum_helper"
p two_sum_helper(arr, 6)
p two_sum_helper(arr, 10)

#Time: O(n^2)
#Space: O(n)
def four_sum?(arr, target_sum)
    all_two_sums = []
    (min_two_sum(arr)..target_sum / 2).each do |sum_1| #linear (though it varies based on length of array vs smallest integer)
        all_two_sums << [sum_1, target_sum - sum_1] #constant
    end
    all_two_sums.each do |sums| #linear
        nums = arr.dup #linear
        first_pair = two_sum_helper(nums, sums.first) #nlogn
        if first_pair
            first_pair.each { |num| nums.delete(num) } #linear
            second_pair = two_sum_helper(nums, sums.last) #nlogn
        end
        return true if first_pair && second_pair #constant
    end
    false
end

long_arr = [-2, -8, 2, 6, 5, 22, 1, 9, 16]

p "four_sum"
p four_sum?(arr, 13) #=> true
p four_sum?(arr, 10) #=> false
p four_sum?(long_arr, 45) #  => true
p four_sum?(long_arr, -4) #  => true
p four_sum?(long_arr, 10) # => true
p four_sum?(long_arr, 4) # => true
p four_sum?(long_arr, 100) # => false
p four_sum?(long_arr, -20) # => false